'use strict';
// Timed quest items (docs/GUIDE_FORMAT.md, "Validation"): an item that
// vanishes a while after the player gets it (items.json `duration`, the
// Forever client's ItemSparse DurationInInventory) must reach the goal that
// uses or turns it in before it does. A guide gets one by an `accept` whose
// quest hands it over (`sourceItem`), a `collect` or a `buy`; a later `turnin`
// of a quest that needs it (handed over, an item objective, a required item)
// or a `use` of it spends it. Each goal that spends it is timed from the
// latest goal before it that gets it (one `buy x3` for three turn-ins: to the
// third; three `collect`s for three quests: from the third), so the stretch
// is the least the item must last. Lint estimates its time with
// the simulator's model (docs/legacy/SIMULATION-js.md §2) at its priors
// (tools/lib/sim/params.js) over the guide's own goals and places:
//   - travel: the straight line × the continent's detour factor at run speed
//     (mounted from `mountLevel`); `fly` walks to the nearest flight master
//     and takes the cheapest flights (travel.json, plus `flightOverhead`);
//     `hearth` casts and lands at the inn it names;
//   - work: `talkSec` per accept, turn-in, talk, purchase, trainer, bind or
//     flight path; `interactSec` per object or item use; per kill the kill
//     time at the character's level (fight and downtime, by level
//     difference, elites × `eliteTime`) plus the walk to the next mob of the
//     goal's spawn areas, kills × (1 + `extraKill`); a `collect` costs the
//     kills or uses its best source needs at its drop chance;
//   - left out: goals for other characters (`only`) and `optional` ones,
//     grinding (`level`), legs whose ends are unknown or on two continents.
// So the estimate errs short: a warning means the item very likely expires.
// A `collect` counts from its first item, an `accept` or `buy` from the goal.
//
// checkTimedItems(g, data, diag, { levelAt, characters, meets }):
//   levelAt(goal) -> the character's level there (route XP, validate.js);
//   characters(step, goal) -> the goal's character keys; meets(a, b).

const { PRIORS } = require('../sim/params');

// The simulator's parameters at their prior means.
const P = Object.fromEntries(Object.entries(PRIORS).map(([k, v]) => [k, v[0]]));
const ELITE = new Set([1, 2, 3]);
const DEFAULT_SPACING = 30; // yards between mobs where the goal has no spawn areas (sim world grind default)
const MIN_SPACING = 12;
const TALK = new Set(['accept', 'turnin', 'talk', 'getfp', 'sethome', 'train', 'vendor', 'buy', 'learn']);
const SIDE = { Alliance: 1, Horde: 2 };

// World position { c, wx, wy } of a compiled point (frame "e" Era, else live,
// read with the Era bounds when the live ones are unknown), or null.
function place(data, map, x, y, f) {
	if (map === undefined || x === undefined || y === undefined) return null;
	const era = (data.mapFrames && data.mapFrames.era) || {};
	const live = (data.mapFrames && data.mapFrames.forever) || {};
	const b = f === 'e' ? era[map] : live[map] || era[map];
	if (!b) return null;
	return { c: b.c, wx: b.top + ((b.bottom - b.top) * y) / 100, wy: b.left + ((b.right - b.left) * x) / 100 };
}

function detour(c) {
	return c === 0 ? P.detour0 : c === 1 ? P.detour1 : (P.detour0 + P.detour1) / 2;
}

function yards(a, b) {
	return a && b && a.c === b.c ? Math.hypot(a.wx - b.wx, a.wy - b.wy) : Infinity;
}

function walkSec(a, b, mounted) {
	if (!a || !b || a.c !== b.c) return 0;
	return (yards(a, b) * detour(a.c)) / (P.runSpeed * (mounted ? P.mountMul : 1));
}

function lower(s) {
	return String(s || '').trim().toLowerCase();
}

// Seconds per kill of a mob of level M (elite or not) at character level L.
function killSec(L, M, elite) {
	const base = P.killSec1 + ((P.killSec60 - P.killSec1) * (Math.max(1, Math.min(60, L)) - 1)) / 59;
	const d = M - L;
	const f = d >= 0 ? 1 + P.killUp * d : Math.max(0.5, 1 + P.killDown * d);
	return base * f * P.classFactor * (elite ? P.eliteTime : 1);
}

// A mob's level: the middle of its range (as the simulator's world takes it).
function npcLevel(npc, fallback) {
	const lo = npc ? Number.parseInt(npc.level, 10) : NaN;
	if (!Number.isFinite(lo)) return fallback;
	const hi = Number.parseInt(npc.levelMax, 10);
	return Math.round((lo + (Number.isFinite(hi) ? hi : lo)) / 2);
}

// Mean yards from one mob to the next in the goal's spawn areas (radius r,
// n spawns each): half the side of the area each spawn has.
function spacing(goal) {
	const spots = (goal.spots || []).filter((s) => s.r > 0 && s.n > 0);
	if (!spots.length) return DEFAULT_SPACING;
	let sum = 0;
	let n = 0;
	for (const s of spots) {
		sum += s.n * 0.5 * Math.sqrt((Math.PI * s.r * s.r) / s.n);
		n += s.n;
	}
	return Math.max(MIN_SPACING, sum / n);
}

// Seconds for one kill of npc at level L, the walk to it included.
function perKill(data, npcId, L, goal) {
	const npc = data.npc(npcId);
	return killSec(L, npcLevel(npc, L), npc && ELITE.has(npc.rank)) + (spacing(goal) * P.spacing) / P.runSpeed;
}

// Seconds for one item of a `collect`: its quickest source (kills or uses at
// its drop chance; a chance the data lacks counts as certain; no rare spawns)
// among those spawning within NEAR yards of the goal's place, else on its
// map, else anywhere. A goal without sources costs a talk when a vendor
// sells the item, else nothing.
const NEAR = 300;
function perItem(data, goal, L) {
	const it = data.item(goal.item);
	if (!it) return 0;
	const drops = it.drops || {};
	const at = place(data, goal.map, goal.x, goal.y, goal.f);
	let best = null;
	for (const kind of ['npc', 'object']) {
		for (const [id, raw] of Object.entries(drops[kind] || {})) {
			const chance = raw == null ? 100 : Math.min(100, Number(raw));
			if (!(chance > 0)) continue;
			const e = kind === 'npc' ? data.npc(Number(id)) : null;
			if (e && e.rank === 4) continue;
			const spawns = data.spawns(kind, Number(id));
			const onMap = spawns.filter((s) => s.map === goal.map);
			const near = at && onMap.some((s) => [...s.pts, ...s.more].some(([x, y]) => yards(at, place(data, s.map, x, y, s.f)) <= NEAR));
			const tier = near ? 0 : onMap.length ? 1 : 2;
			const sec = (100 / chance) * (kind === 'npc' ? (1 + P.extraKill) * perKill(data, Number(id), L, goal) : P.interactSec);
			if (!best || tier < best.tier || (tier === best.tier && sec < best.sec)) best = { tier, sec };
		}
	}
	if (!best) return (it.vendors || []).length ? P.talkSec : 0;
	return best.sec;
}

// A flight: yards along the taxi path a second, and seconds per hop (take-off,
// landing), the addon planner's (addon/Polestar/Nav/Travel.lua FLIGHT_SPEED,
// FLIGHT_STOP; the sim's v2/travel2.js uses the same). travel.json's leg `cost`
// is TaxiPath.dbc's price in copper, not seconds.
const FLIGHT_SPEED = 30;
const FLIGHT_STOP = 2;

// Cheapest flight seconds from taxi node a to every node (Dijkstra over
// travel.json's legs, each its yards / FLIGHT_SPEED + FLIGHT_STOP; the faction's nodes only).
function flights(data, side) {
	const taxi = (data.travel && data.travel.taxi) || {};
	const nodes = (taxi.nodes || []).filter((n) => !side || n.faction & side);
	const ids = new Set(nodes.map((n) => n.id));
	const out = new Map();
	for (const l of taxi.legs || []) {
		if (!ids.has(l.from) || !ids.has(l.to)) continue;
		if (!out.has(l.from)) out.set(l.from, []);
		out.get(l.from).push([l.to, l.yards / FLIGHT_SPEED + FLIGHT_STOP]);
	}
	const memo = new Map();
	const from = (a) => {
		if (memo.has(a)) return memo.get(a);
		const dist = new Map([[a, 0]]);
		const open = [a];
		while (open.length) {
			open.sort((x, y) => dist.get(y) - dist.get(x));
			const n = open.pop();
			for (const [m, c] of out.get(n) || []) {
				const d = dist.get(n) + c;
				if (d < (dist.has(m) ? dist.get(m) : Infinity)) {
					if (!dist.has(m)) open.push(m);
					dist.set(m, d);
				}
			}
		}
		memo.set(a, dist);
		return dist;
	};
	return { nodes, from };
}

// A `fly` from pos: walk to the nearest flight master with a flight to the
// named town, fly, land there. -> { sec, pos } (pos null when unknown).
function fly(data, net, pos, location, mounted) {
	const q = lower(location);
	const to = net.nodes.filter((n) => lower(n.short) === q || lower(n.name) === q);
	if (!to.length) return { sec: 0, pos: null };
	let best = null;
	for (const dest of to) {
		const at = { c: dest.c, wx: dest.wx, wy: dest.wy };
		if (!pos) {
			if (!best) best = { sec: 0, pos: at };
			continue;
		}
		for (const n of net.nodes) {
			if (n.c !== pos.c) continue;
			const air = net.from(n.id).get(dest.id);
			if (air === undefined) continue;
			const sec = walkSec(pos, n, mounted) + air + P.flightOverhead;
			if (!best || sec < best.sec) best = { sec, pos: at };
		}
	}
	return best || { sec: 0, pos: null };
}

function inn(data, location) {
	const q = lower(location);
	const hit = data.inns().find((i) => lower(i.location) === q || (i.names || []).some((n) => lower(n) === q));
	return hit ? { c: hit.c, wx: hit.wx, wy: hit.wy } : null;
}

// Seconds of a goal's own work at level L (travel apart).
function workSec(data, goal, L) {
	if (TALK.has(goal.t)) return P.talkSec;
	const count = goal.count > 0 ? goal.count : 1;
	if (goal.t === 'kill' && goal.npc !== undefined) return count * (1 + P.extraKill) * perKill(data, goal.npc, L, goal);
	if (goal.t === 'collect') return count * perItem(data, goal, L);
	if (goal.t === 'interact') return count * P.interactSec;
	if (goal.t === 'use') return P.interactSec;
	return 0;
}

// How many of item x the turn-in of quest q spends (0: none): one handed
// over or required, else the item objective's count, else what the guide
// collects of it for q (`collected`), else one.
function spends(q, x, collected) {
	if (!q) return 0;
	if (q.sourceItem === x || (q.requiredItems || []).includes(x)) return 1;
	const o = (q.objectives || []).find((o) => o.type === 'item' && o.id === x);
	if (!o) return 0;
	return o.count > 0 ? o.count : collected > 0 ? collected : 1;
}

function fmt(sec) {
	const s = Math.round(sec);
	if (s < 3600) return `${Math.floor(s / 60)}:${String(s % 60).padStart(2, '0')}`;
	return `${Math.floor(s / 3600)} h ${String(Math.floor((s % 3600) / 60)).padStart(2, '0')} min`;
}

function lasts(sec) {
	if (sec % 3600 === 0) return sec === 3600 ? 'an hour' : `${sec / 3600} hours`;
	if (sec % 60 === 0) return sec === 60 ? 'a minute' : `${sec / 60} minutes`;
	return `${sec} seconds`;
}

// Every stretch a guide carries a timed item: [{ item, from, to, seconds }]
// (from: the goal that gets it; to: the last goal that spends what it got;
// seconds: the estimate).
function timedSpans(g, data, { levelAt, characters, meets }) {
	const list = g.steps.flatMap((step) => step.goals.map((goal) => ({ step, goal })));
	// The timed item a goal gets, if any.
	const gets = (goal) => {
		let x;
		if (goal.t === 'accept') {
			const q = data.quest(goal.quest);
			x = q && q.sourceItem;
		} else if (goal.t === 'collect' || goal.t === 'buy') x = goal.item;
		const it = x !== undefined && x !== null ? data.item(x) : null;
		return it && it.duration > 0 ? it : null;
	};
	const spans = [];
	if (!list.some(({ goal }) => gets(goal))) return spans;
	const side = SIDE[g.faction] || 0;
	let net = null;
	const minL = g.minLevel || 1;
	const maxL = g.maxLevel || 60;
	const level = (goal) => Math.max(minL, Math.min(maxL, levelAt(goal) || minL));
	const chars = list.map(({ step, goal }) => characters(step, goal));
	const units = (goal) => (goal.t === 'accept' ? 1 : goal.count > 0 ? goal.count : 1);
	list.forEach(({ goal }, i) => {
		const it = gets(goal);
		if (!it) return;
		const mine = chars[i];
		// The goals spending what this one got: the items in the bags are
		// spent newest first (so the stretch is the least they must last),
		// a goal getting more of it puts its items on top.
		const stack = [{ i, n: units(goal) }];
		const collected = new Map(goal.t === 'collect' && goal.quest !== undefined ? [[goal.quest, units(goal)]] : []);
		let k = -1;
		for (let j = i + 1; j < list.length && stack.length && stack[0].i === i; j++) {
			const o = list[j].goal;
			if (!meets(chars[j], mine)) continue;
			const got = gets(o);
			if (got && got.id === it.id) {
				stack.push({ i: j, n: units(o) });
				if (o.t === 'collect' && o.quest !== undefined) collected.set(o.quest, units(o));
				continue;
			}
			let need = o.t === 'turnin' ? spends(data.quest(o.quest), it.id, collected.get(o.quest)) : o.t === 'use' && o.item === it.id ? 1 : 0;
			while (need > 0 && stack.length) {
				const top = stack[stack.length - 1];
				const take = Math.min(need, top.n);
				top.n -= take;
				need -= take;
				if (top.i === i) k = j;
				if (!top.n) stack.pop();
			}
		}
		if (k < 0) return;
		// Where the character stands at the source: its place, else the last located goal before it.
		let pos = place(data, goal.map, goal.x, goal.y, goal.f);
		for (let j = i - 1; !pos && j >= 0; j--) pos = place(data, list[j].goal.map, list[j].goal.x, list[j].goal.y, list[j].goal.f);
		const L0 = level(goal);
		let t = goal.t === 'collect' ? perItem(data, goal, L0) : workSec(data, goal, L0);
		for (let j = i + 1; j <= k; j++) {
			const o = list[j].goal;
			if (j < k && (o.optional || !meets(chars[j], mine))) continue;
			const L = level(o);
			const mounted = L >= P.mountLevel;
			if (o.t === 'fly') {
				net = net || flights(data, side);
				const leg = fly(data, net, pos, o.location, mounted);
				t += leg.sec;
				pos = leg.pos;
				continue;
			}
			if (o.t === 'hearth') {
				t += P.hearthCast;
				pos = inn(data, o.location);
				continue;
			}
			const at = place(data, o.map, o.x, o.y, o.f);
			if (at) {
				t += walkSec(pos, at, mounted);
				pos = at;
			}
			if (j < k) t += workSec(data, o, L);
		}
		spans.push({ item: it, from: goal, to: list[k].goal, seconds: t });
	});
	return spans;
}

function checkTimedItems(g, data, diag, opts) {
	for (const { item, from, to, seconds } of timedSpans(g, data, opts)) {
		if (seconds <= item.duration) continue;
		diag.warn(
			g._ast.file,
			from._line,
			`item ${item.id} (${item.name}) lasts ${lasts(item.duration)}, but the route takes about ${fmt(seconds)} from here to the \`${to.t}\` that spends it (line ${to._line})`,
			"get it later, nearer that goal, or go there straight away (the estimate is the simulator's travel and kill times over this guide's goals: docs/legacy/SIMULATION-js.md)",
		);
	}
}

module.exports = { checkTimedItems, timedSpans, flights, FLIGHT_SPEED, FLIGHT_STOP };
