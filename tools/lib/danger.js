'use strict';
// Danger at the spot (#1575): for every located kill/collect/use/interact/complete goal of the leveling guides
// (forever/alliance, forever/horde), the hostile mobs around it against the level the route expects there.
//
//   levelsOf(files) -> Map(guide id -> { start, q: Map(quest -> level after its turn-in) })
//     files: the calibrated level model's output for each faction (the release audit's level run: an array of race x class
//     branches, each { rows: [{ id, start, tq: [[quest, level], ...] }] }); levels are the mean over the branches.
//   sweep({ dataDir, guidesDir, levels, guides? }) -> [{ key, guide, step, title, goal, quest, oi, kind, level,
//     margin, mobs: [...] }]
//   compare(flags, baseline) -> { fail: [flag], borderline: [flag], stale: [row] }
//   flagGoal({ goal, level, near, npcs, group, side }) -> [{ kind, margin, mobs }]   the rules, for one goal (side: A or H)
//
// The level at a goal is the route's (the level model's level after the last turn-in before the step, raised by the
// guide's own `level` goals), not the guide's title range. The rules (each flag's margin is how far past its
// threshold it is):
//   target  the goal's own mobs (a kill's npc, else the easiest dropper it targets; rares apart) more than 3 levels over
//   over    other mobs more than 3 levels over within R yd (two spawns or more)
//   elite   an elite within R yd at most 2 levels under the player or higher, on a goal not marked group
//   rare    a rare within RARE_R yd more than 2 levels over
//   pack    6 or more spawns within R yd 2 or more levels over
//   mixed   #1695's pattern: an item several mobs drop, some at the player's level and some more than 3 over, on a
//           goal that tours spots: the arrow can send the player to the high ones
// A flag is identified by guide, goal and kind (`key`), never by the step's number, so steps moving around keep their
// baseline rows. compare() fails on a key the baseline lacks when its margin is GATE_MARGIN or more; one closer to its
// threshold is reported as borderline (a level model's tenth of a level must not flip the gate).

const fs = require('node:fs');
const path = require('node:path');
const { compileSources } = require('./dsl/project');
const { loadData } = require('./dsl/data');
const { Geo } = require('./planner/geo.js');

const R = 40;
const RARE_R = 80;
const CELL = 50;
const GATE_MARGIN = 0.5;
const KINDS = ['target', 'over', 'elite', 'rare', 'pack', 'mixed'];
const WORK = new Set(['kill', 'collect', 'use', 'interact', 'complete']);

const top = (n) => n.levelMax || n.level;
const isRare = (n) => n.rank === 2 || n.rank === 4;
const isElite = (n) => n.rank === 1 || n.rank === 3;
// Templates whose level spans more than 5 (critters such as Cat 7-30 or Hawk 20-30, summoned pets) or sits at the
// game's boss sentinel (63+, 9999) say nothing about the mobs a player meets: never counted.
const counts = (n) => !!n && !!n.level && top(n) - n.level <= 5 && n.level < 63;
const hostileTo = (n, side) => !(n.faction && n.faction.includes(side));

function levelsOf(files) {
	const per = new Map();
	for (const file of files) {
		for (const branch of JSON.parse(fs.readFileSync(file, 'utf8'))) {
			for (const r of branch.rows || []) {
				if (!per.has(r.id)) per.set(r.id, { start: [], q: new Map() });
				const g = per.get(r.id);
				g.start.push(r.start);
				for (const [q, l] of r.tq || []) {
					if (!g.q.has(q)) g.q.set(q, []);
					g.q.get(q).push(l);
				}
			}
		}
	}
	const mean = (a) => a.reduce((s, v) => s + v, 0) / a.length;
	const out = new Map();
	for (const [id, g] of per) out.set(id, { start: mean(g.start), q: new Map([...g.q].map(([q, a]) => [q, mean(a)])) });
	return out;
}

// near: [{ id, count (spawns within R), dmin (yd) }] for the hostile npcs within RARE_R of the goal's points.
function flagGoal({ goal, level, near, npcs, group, side = null }) {
	const flags = [];
	const named = (list) => list.map((m) => `${npcs[m.id].name} ${npcs[m.id].level}-${top(npcs[m.id])}${m.count > 1 ? ' x' + m.count : ''}`);
	const ids = goal.npc ? [goal.npc] : (goal.fromNpcs || []).map((x) => x.npc);
	const targets = new Set(ids);
	// The goal's own mobs, when they're the side's enemies: a kill objective on a friendly leader is a talk.
	const own = ids.map((id) => npcs[id]).filter((n) => counts(n) && !isRare(n) && (!side || hostileTo(n, side)));
	if (own.length) {
		const easiest = Math.min(...own.map(top));
		if (easiest > level + 3) flags.push({ kind: 'target', margin: easiest - (level + 3), mobs: own.map((n) => `${n.name} ${n.level}-${top(n)}`) });
	}
	const inR = near.filter((m) => m.dmin <= R && top(npcs[m.id]) >= level - 6);
	const over = inR.filter((m) => !targets.has(m.id) && top(npcs[m.id]) > level + 3 && m.count >= 2);
	if (over.length) flags.push({ kind: 'over', margin: Math.max(...over.map((m) => top(npcs[m.id]))) - (level + 3), mobs: named(over) });
	const elites = inR.filter((m) => isElite(npcs[m.id]) && top(npcs[m.id]) >= level - 2);
	if (elites.length && !group) flags.push({ kind: 'elite', margin: Math.max(...elites.map((m) => top(npcs[m.id]))) - (level - 2), mobs: named(elites) });
	const rares = near.filter((m) => isRare(npcs[m.id]) && top(npcs[m.id]) > level + 2);
	if (rares.length) flags.push({ kind: 'rare', margin: Math.max(...rares.map((m) => top(npcs[m.id]))) - (level + 2), mobs: named(rares) });
	const packed = inR.filter((m) => top(npcs[m.id]) >= level + 2);
	const pack = packed.reduce((s, m) => s + m.count, 0);
	// The margin: the smaller of how far the strongest is past the line and how far the count is past six (half a level a
	// spawn), so a pack that only just counts six stays borderline.
	if (pack >= 6) flags.push({ kind: 'pack', margin: Math.min(Math.max(...packed.map((m) => top(npcs[m.id]))) - (level + 2), (pack - 6) / 2), mobs: [`${pack} spawns ${Math.floor(level) + 2}+`] });
	if (goal.t === 'collect' && own.length > 1 && (goal.spots || []).length > 1) {
		const hi = own.filter((n) => top(n) > level + 3 && Object.values(n.spawns || {}).reduce((s, v) => s + (v.pts || []).length, 0) >= 2);
		const lo = own.filter((n) => top(n) <= level + 2);
		if (hi.length && lo.length) flags.push({ kind: 'mixed', margin: Math.max(...hi.map(top)) - (level + 3), mobs: hi.map((n) => `${n.name} ${n.level}-${top(n)}`) });
	}
	return flags;
}

function sweep({ dataDir, guidesDir, levels, guides = null }) {
	const data = loadData(dataDir);
	const npcs = JSON.parse(fs.readFileSync(path.join(dataDir, 'npcs.json'), 'utf8'));
	const geo = new Geo(JSON.parse(fs.readFileSync(path.join(dataDir, 'map-frames.json'), 'utf8')), JSON.parse(fs.readFileSync(path.join(dataDir, 'zones.json'), 'utf8')));
	const world = (map, x, y, f) => {
		const w = geo.toWorld(map, x, y, f === 'e' ? 'e' : 'l');
		return w ? { c: w.c, x: w.wx ?? w[0], y: w.wy ?? w[1] } : null;
	};
	// Hostile spawns per side on a CELL-yard grid (an npc friendly to a side is no danger to it).
	const grid = { A: new Map(), H: new Map() };
	for (const [id, n] of Object.entries(npcs)) {
		if (!n.spawns || !counts(n)) continue;
		for (const side of ['A', 'H']) {
			if (n.faction && n.faction.includes(side)) continue;
			for (const [map, s] of Object.entries(n.spawns)) {
				for (const [x, y] of s.pts || []) {
					const w = world(+map, x, y, s.f);
					if (!w) continue;
					const k = `${w.c}:${Math.floor(w.x / CELL)}:${Math.floor(w.y / CELL)}`;
					if (!grid[side].has(k)) grid[side].set(k, []);
					grid[side].get(k).push({ id: +id, w });
				}
			}
		}
	}
	const around = (side, w) => {
		const out = [];
		const cx = Math.floor(w.x / CELL), cy = Math.floor(w.y / CELL), k = Math.ceil(RARE_R / CELL);
		for (let i = -k; i <= k; i++) for (let j = -k; j <= k; j++) {
			for (const s of grid[side].get(`${w.c}:${cx + i}:${cy + j}`) || []) {
				const d = Math.hypot(s.w.x - w.x, s.w.y - w.y);
				if (d <= RARE_R) out.push({ id: s.id, d });
			}
		}
		return out;
	};
	const files = [];
	(function walk(d) {
		for (const e of fs.readdirSync(d, { withFileTypes: true })) {
			const p = path.join(d, e.name);
			if (e.isDirectory()) walk(p);
			else if (p.endsWith('.guide')) files.push(p);
		}
	})(path.join(guidesDir, 'forever'));
	const flags = [];
	for (const file of files.sort()) {
		const rel = path.relative(guidesDir, file).split(path.sep).join('/');
		const faction = rel.startsWith('forever/alliance/') ? 'Alliance' : rel.startsWith('forever/horde/') ? 'Horde' : null;
		if (!faction || (guides && !guides.includes(rel))) continue;
		const g = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], data).guides[0];
		if (!g) continue;
		const lm = levels.get(g.id);
		let level = lm ? lm.start : g.minLevel || 1;
		g.steps.forEach((step, si) => {
			for (const goal of step.goals) {
				if (goal.t === 'level') level = Math.max(level, goal.level);
				if (goal.t === 'turnin' && lm && lm.q.has(goal.quest)) level = Math.max(level, lm.q.get(goal.quest));
			}
			for (const goal of step.goals) {
				if (!WORK.has(goal.t) || goal.map == null || goal.x == null) continue;
				if (goal.t === 'collect' && !goal.quest) continue;
				const seen = new Map();
				for (const p of [{ x: goal.x, y: goal.y }, ...(goal.spots || []).slice(0, 4)]) {
					const w = world(goal.map, p.x, p.y, goal.f);
					if (!w) continue;
					for (const s of around(faction[0], w)) {
						const m = seen.get(s.id) || { id: s.id, count: 0, dmin: Infinity };
						if (s.d <= R) m.count++;
						m.dmin = Math.min(m.dmin, s.d);
						seen.set(s.id, m);
					}
				}
				const what = goal.quest ? `${goal.quest}${goal.oi ? '.' + goal.oi : ''}` : goal.npc ? `npc ${goal.npc}` : `item ${goal.item}`;
				for (const f of flagGoal({ goal, level, near: [...seen.values()], npcs, group: !!goal.group, side: faction[0] })) {
					flags.push({ key: `${rel}|${goal.t} ${what}|${f.kind}`, guide: rel, step: si + 1, title: step.title, goal: `${goal.t} ${what}`, quest: goal.quest || null, oi: goal.oi || null, kind: f.kind, level: +level.toFixed(1), margin: +f.margin.toFixed(2), mobs: f.mobs, at: { map: goal.map, x: goal.x, y: goal.y, f: goal.f || 'l' } });
				}
			}
		});
	}
	// One flag per key: the strongest (a goal worked in two steps).
	const byKey = new Map();
	for (const f of flags) if (!byKey.has(f.key) || byKey.get(f.key).margin < f.margin) byKey.set(f.key, f);
	return [...byKey.values()];
}

function compare(flags, baseline) {
	const known = new Set(baseline.map((r) => r.key));
	const now = new Set(flags.map((f) => f.key));
	const fresh = flags.filter((f) => !known.has(f.key));
	return {
		fail: fresh.filter((f) => f.margin >= GATE_MARGIN),
		borderline: fresh.filter((f) => f.margin < GATE_MARGIN),
		stale: baseline.filter((r) => !now.has(r.key)),
	};
}

module.exports = { levelsOf, sweep, compare, flagGoal, KINDS, GATE_MARGIN, R, RARE_R };
