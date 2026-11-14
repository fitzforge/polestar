'use strict';
// Danger at the spot (#1575): for every located kill/collect/use/interact/complete goal of the leveling guides
// (forever/alliance, forever/horde), the hostile mobs around it against the level the route expects there; and for
// every grind (a `level` goal the route reaches by grinding, #2207), its camp against the level the grind starts at.
//
//   levelsOf(files) -> Map(guide id -> { start, q: Map(quest -> level after its turn-in) })
//     files: the calibrated level model's output for each faction (the release audit's level run: an array of race x class
//     branches, each { rows: [{ id, start, tq: [[quest, level], ...] }] }); levels are the mean over the branches.
//   sweep({ dataDir, guidesDir, levels, guides?, archive? }) -> { flags: [{ key, guide, step, title, goal, quest, oi,
//     kind, level, levelEnd (grind), margin, mobs: [...] }], census: null | { sessions, cleared: [...], added: [...] } }
//   compare(flags, baseline) -> { fail: [flag], borderline: [flag], stale: [row] }
//   flagGoal({ goal, level, near, npcs, group, side }) -> [{ kind, margin, mobs }]   the rules, for one goal (side: A or H)
//   flagGrind({ goal, start, end, near, npcs }) -> [{ kind, margin, mobs }]   the grind rule, for one `level` goal
//   threatTo(npc, side, census?) -> whether the npc attacks the side's players (below, "Who is a threat")
//   readCensus(dir, { world, targets }) -> census   players' recordings: who met each npc and as what, who died to it,
//     and how many people's census ran within R yd of each target's spawns (targets: Map(npc -> [{ c, x, y }]))
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
//   grind   #2207's pattern: a `level` goal over the route's level at the step's start (the route grinds there) whose
//           camp's common mobs stand 2 or more levels over the player's level then (a level-46 character on 48s,
//           whatever share of 46 it has). The camp is the goal's `grind` mob, else the spawn-weighted middle level of
//           the mobs with two spawns or more within R yd of its points (elites and rares apart: the rules above flag
//           those). The margin is the grind's length weighted by how far over the camp is: each share of a level
//           ground with the camp 2 over counts once, 3 over twice, and so on (a top-up of a few hundredths of a level,
//           where the level model falls just short of the goal, stays borderline)
// A flag is identified by guide, goal and kind (`key`), never by the step's number, so steps moving around keep their
// baseline rows. compare() fails on a key the baseline lacks when its margin is GATE_MARGIN or more; one closer to its
// threshold is reported as borderline (a level model's tenth of a level must not flip the gate).
//
// Who is a threat: npcs.json's `faction` is the side an npc serves. It is null for a hostile mob, but also for an
// NPC friendly to both sides that sells nothing (the quest data's "friendly to both" is dropped then, and it is wrong
// for some hostile mobs, Stitches among them), for Forever's new NPCs whose side no source gives, and for templates
// the quest data places where the game shows none (Season of Discovery leftovers, event spawns). Without players'
// recordings every npc of no side counts as hostile. With the recordings archive (`archive`: the Recorder's unit
// census, every npc a player saw with its reaction to that player, and what killed them), a template is
//   - a threat to a side when one of its players met it as hostile or died to it, whatever the data says;
//   - none when the side's players met it as friendly (some may see it neutral: reputation) and never as hostile;
//   - none when nobody ever met it or died to it though CENSUS_MIN people's census ran within R yd of its spawns:
//     players don't meet it there (rares apart: they are seldom up);
//   - else as the data says: one met only as neutral still counts (players fight neutral mobs, and quest targets
//     such as the Dalaran traitors are neutral until attacked).

const fs = require('node:fs');
const path = require('node:path');
const { compileSources } = require('./dsl/project');
const { loadData } = require('./dsl/data');
const { Geo } = require('./planner/geo.js');

const R = 40;
const RARE_R = 80;
const CELL = 50;
const GATE_MARGIN = 0.5;
// People whose census ran around a template's spawns before "nobody met it" says players don't meet it there: about
// two passers in three log a hostile mob that stands there (the census around the gate's flags, 2026-11), so fifteen
// all missing one is chance (1 in 10^7) or a mob seldom there.
const CENSUS_MIN = 15;
const KINDS = ['target', 'over', 'elite', 'rare', 'pack', 'mixed', 'grind'];
const WORK = new Set(['kill', 'collect', 'use', 'interact', 'complete']);

const top = (n) => n.levelMax || n.level;
const isRare = (n) => n.rank === 2 || n.rank === 4;
const isElite = (n) => n.rank === 1 || n.rank === 3;
// Templates whose level spans more than 5 (critters such as Cat 7-30 or Hawk 20-30, summoned pets) or sits at the
// game's boss sentinel (63+, 9999) say nothing about the mobs a player meets: never counted.
const counts = (n) => !!n && !!n.level && top(n) - n.level <= 5 && n.level < 63;
// A goal's own mob is a fight unless it serves the side (a kill objective on a friendly leader is a talk).
const hostileTo = (n, side) => !(n.faction && n.faction.includes(side));

// Whether n attacks the side's players (A or H): the census first, else the data (header, "Who is a threat").
function threatTo(n, side, census = null) {
	const met = census && census.met.get(n.id);
	const died = census && census.died.get(n.id);
	if ((met && met[side].hostile.size) || (died && died[side].size)) return true;
	if (met && met[side].friendly.size) return false;
	if (census && !met && !died && !isRare(n) && (census.near.get(n.id) || 0) >= CENSUS_MIN) return false;
	return hostileTo(n, side);
}

// The Recorder's census in a recordings archive (its session files; config.json's `exclude` contributors left out):
// every `unit` and `rare` sighting (the npc, its reaction to the player, where the player stood), every kill out in
// the world (a meeting too, of no known reaction) and every death with its killer. Only sightings on the ground
// count toward the people whose census ran by a spawn (one seen from a flight saw from high above). A person is a
// voter as the data build counts them (rust/crates/forge-data/src/recordings.rs): the session's cohort, else its
// contributor. world(map, x, y) -> { c, x, y } in yards, or null.
const REACT = new Set(['hostile', 'friendly']);
const meet = (met, npc) => {
	if (!met.has(npc)) met.set(npc, { A: { hostile: new Set(), friendly: new Set() }, H: { hostile: new Set(), friendly: new Set() } });
	return met.get(npc);
};
function readCensus(dir, { world, targets }) {
	const config = path.join(dir, 'config.json');
	const exclude = new Set((fs.existsSync(config) && JSON.parse(fs.readFileSync(config, 'utf8')).exclude) || []);
	const key = (c, cx, cy) => (c * 8192 + cx + 4096) * 8192 + cy + 4096;
	const points = new Map();
	for (const [id, pts] of targets) {
		for (const w of pts) {
			const k = key(w.c, Math.floor(w.x / R), Math.floor(w.y / R));
			if (!points.has(k)) points.set(k, []);
			points.get(k).push({ id, w });
		}
	}
	const met = new Map();
	const died = new Map();
	const near = new Map();
	let sessions = 0;
	for (const file of fs.readdirSync(dir).filter((f) => f.endsWith('.json') && f !== 'config.json' && !f.startsWith('.')).sort()) {
		let s;
		try {
			s = JSON.parse(fs.readFileSync(path.join(dir, file), 'utf8'));
		} catch {
			continue;
		}
		const side = s && s.char && { Alliance: 'A', Horde: 'H' }[s.char.faction];
		const contributor = (s && s.contributor) || 'local';
		if (!side || !Array.isArray(s.events) || exclude.has(contributor)) continue;
		const who = /^[0-9a-f]{16}$/.test(s.cohort || '') ? `cohort:${s.cohort}` : contributor;
		sessions++;
		let aloft = false;
		for (const e of s.events) {
			if (!e) continue;
			if (e.e === 'taxi' || e.e === 'land') aloft = e.e === 'taxi';
			if (e.e === 'death') {
				if (!e.killer) continue;
				if (!died.has(e.killer)) died.set(e.killer, { A: new Set(), H: new Set() });
				died.get(e.killer)[side].add(who);
				continue;
			}
			if (e.e === 'kill' && e.npc && e.map != null && e.inst == null) meet(met, e.npc);
			if ((e.e !== 'unit' && e.e !== 'rare') || !e.npc) continue;
			const m = meet(met, e.npc);
			if (REACT.has(e.react)) m[side][e.react].add(who);
			const w = !aloft && e.map != null && e.x != null ? world(e.map, e.x, e.y) : null;
			if (!w) continue;
			const cx = Math.floor(w.x / R);
			const cy = Math.floor(w.y / R);
			for (let i = -1; i <= 1; i++) {
				for (let j = -1; j <= 1; j++) {
					for (const p of points.get(key(w.c, cx + i, cy + j)) || []) {
						if (Math.hypot(p.w.x - w.x, p.w.y - w.y) > R) continue;
						if (!near.has(p.id)) near.set(p.id, new Set());
						near.get(p.id).add(who);
					}
				}
			}
		}
	}
	return { sessions, met, died, near: new Map([...near].map(([id, people]) => [id, people.size])) };
}

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

// A grind's camp against the player (the `grind` rule above). goal: the `level` goal (its `grind` mob, if named);
// start: the route's level when the step starts; end: the goal's level; near: as flagGoal's, around the goal's points.
function flagGrind({ goal, start, end, near, npcs }) {
	if (!(end > start)) return [];
	const common = near.filter((m) => m.dmin <= R && m.count >= 2 && !isRare(npcs[m.id]) && !isElite(npcs[m.id]));
	const target = goal.grind != null ? npcs[goal.grind] : null;
	let camp;
	if (target && counts(target) && !isRare(target)) camp = top(target);
	else if (common.length) {
		const byLevel = common.map((m) => [top(npcs[m.id]), m.count]).sort((a, b) => a[0] - b[0]);
		let left = byLevel.reduce((s, [, c]) => s + c, 0) / 2;
		camp = byLevel.find(([, c]) => (left -= c) <= 0)[0];
	} else return [];
	const p0 = Math.floor(start);
	if (camp - p0 < 2) return [];
	const named = (id, count) => `${npcs[id].name} ${npcs[id].level}-${top(npcs[id])}${count > 1 ? ' x' + count : ''}`;
	const mobs = common.filter((m) => top(npcs[m.id]) - p0 >= 2 && m.id !== goal.grind).map((m) => named(m.id, m.count));
	if (target && camp === top(target)) mobs.unshift(`${named(goal.grind, (near.find((m) => m.id === goal.grind) || {}).count || 0)} (the grind mob)`);
	let margin = 0;
	for (let p = p0; p < end && camp - p >= 2; p++) margin += (camp - p - 1) * (Math.min(end, p + 1) - Math.max(start, p));
	return [{ kind: 'grind', margin, mobs }];
}

function sweep({ dataDir, guidesDir, levels, guides = null, archive = null }) {
	const data = loadData(dataDir);
	const npcs = JSON.parse(fs.readFileSync(path.join(dataDir, 'npcs.json'), 'utf8'));
	const geo = new Geo(JSON.parse(fs.readFileSync(path.join(dataDir, 'map-frames.json'), 'utf8')), JSON.parse(fs.readFileSync(path.join(dataDir, 'zones.json'), 'utf8')));
	const world = (map, x, y, f) => {
		const w = geo.toWorld(map, x, y, f === 'e' ? 'e' : 'l');
		return w ? { c: w.c, x: w.wx ?? w[0], y: w.wy ?? w[1] } : null;
	};
	// Every counted npc's spawns on a CELL-yard grid; whether one is a threat to a goal's side is settled per goal.
	const grid = new Map();
	const spawnsOf = new Map();
	for (const [id, n] of Object.entries(npcs)) {
		if (!n.spawns || !counts(n)) continue;
		for (const [map, s] of Object.entries(n.spawns)) {
			for (const [x, y] of s.pts || []) {
				const w = world(+map, x, y, s.f);
				if (!w) continue;
				const k = `${w.c}:${Math.floor(w.x / CELL)}:${Math.floor(w.y / CELL)}`;
				if (!grid.has(k)) grid.set(k, []);
				grid.get(k).push({ id: +id, w });
				if (!spawnsOf.has(+id)) spawnsOf.set(+id, []);
				spawnsOf.get(+id).push(w);
			}
		}
	}
	const around = (w) => {
		const out = [];
		const cx = Math.floor(w.x / CELL), cy = Math.floor(w.y / CELL), k = Math.ceil(RARE_R / CELL);
		for (let i = -k; i <= k; i++) for (let j = -k; j <= k; j++) {
			for (const s of grid.get(`${w.c}:${cx + i}:${cy + j}`) || []) {
				const d = Math.hypot(s.w.x - w.x, s.w.y - w.y);
				if (d <= RARE_R) out.push({ id: s.id, d });
			}
		}
		return out;
	};
	// The counted npcs within RARE_R of a goal's points: [{ id, count (spawns within R of a point), dmin (yd) }].
	const nearOf = (goal, pts) => {
		const seen = new Map();
		for (const p of pts) {
			const w = world(goal.map, p.x, p.y, goal.f);
			if (!w) continue;
			for (const s of around(w)) {
				const m = seen.get(s.id) || { id: s.id, count: 0, dmin: Infinity };
				if (s.d <= R) m.count++;
				m.dmin = Math.min(m.dmin, s.d);
				seen.set(s.id, m);
			}
		}
		return [...seen.values()];
	};
	const files = [];
	(function walk(d) {
		for (const e of fs.readdirSync(d, { withFileTypes: true })) {
			const p = path.join(d, e.name);
			if (e.isDirectory()) walk(p);
			else if (p.endsWith('.guide')) files.push(p);
		}
	})(path.join(guidesDir, 'forever'));
	// The work goals and the grinds, each with the counted npcs within RARE_R of its points.
	const work = [];
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
				if (goal.t === 'level') {
					// Over the route's level here, the route grinds: its camp is the goal's point and spots.
					const end = goal.level + (goal.frac || 0);
					if (end > level && goal.map != null && goal.x != null) {
						work.push({ rel, side: faction[0], si, step, goal, level, end, near: nearOf(goal, [{ x: goal.x, y: goal.y }, ...(goal.spots || [])]) });
					}
					level = Math.max(level, goal.level);
				}
				if (goal.t === 'turnin' && lm && lm.q.has(goal.quest)) level = Math.max(level, lm.q.get(goal.quest));
			}
			for (const goal of step.goals) {
				if (!WORK.has(goal.t) || goal.map == null || goal.x == null) continue;
				if (goal.t === 'collect' && !goal.quest) continue;
				work.push({ rel, side: faction[0], si, step, goal, level, near: nearOf(goal, [{ x: goal.x, y: goal.y }, ...(goal.spots || []).slice(0, 4)]) });
			}
		});
	}
	const census = archive
		? readCensus(archive, { world: (map, x, y) => world(map, x, y, 'l'), targets: new Map([...new Set(work.flatMap((w) => w.near.map((m) => m.id)))].map((id) => [id, spawnsOf.get(id)])) })
		: null;
	// Templates around the goals the census settles otherwise than the data: cleared (no threat) or added (a threat).
	const settled = new Map();
	const flags = [];
	for (const { rel, side, si, step, goal, level, end, near } of work) {
		const threats = near.filter((m) => {
			const n = npcs[m.id];
			const t = threatTo(n, side, census);
			if (census && t !== hostileTo(n, side) && !settled.has(`${m.id}:${side}`)) {
				const met = census.met.get(m.id);
				const died = census.died.get(m.id);
				const why = t ? (met && met[side].hostile.size ? 'met hostile' : 'killed one') : met ? 'met friendly' : 'never met';
				const people = t ? new Set([...(met ? met[side].hostile : []), ...(died ? died[side] : [])]).size : met ? met[side].friendly.size : census.near.get(m.id);
				settled.set(`${m.id}:${side}`, { id: m.id, name: n.name, level: top(n), side, threat: t, why, people });
			}
			return t;
		});
		const grind = goal.t === 'level';
		const what = grind ? `${goal.level}${goal.frac ? String(goal.frac).slice(1) : ''}${goal.grind ? ' grind ' + goal.grind : ''}`
			: goal.quest ? `${goal.quest}${goal.oi ? '.' + goal.oi : ''}` : goal.npc ? `npc ${goal.npc}` : `item ${goal.item}`;
		const found = grind ? flagGrind({ goal, start: level, end, near: threats, npcs }) : flagGoal({ goal, level, near: threats, npcs, group: !!goal.group, side });
		for (const f of found) {
			flags.push({ key: `${rel}|${goal.t} ${what}|${f.kind}`, guide: rel, step: si + 1, title: step.title, goal: `${goal.t} ${what}`, quest: goal.quest || null, oi: goal.oi || null, kind: f.kind, level: +level.toFixed(1), ...(grind ? { levelEnd: +end.toFixed(2) } : {}), margin: +f.margin.toFixed(2), mobs: f.mobs, at: { map: goal.map, x: goal.x, y: goal.y, f: goal.f || 'l' } });
		}
	}
	// One flag per key: the strongest (a goal worked in two steps).
	const byKey = new Map();
	for (const f of flags) if (!byKey.has(f.key) || byKey.get(f.key).margin < f.margin) byKey.set(f.key, f);
	const list = [...settled.values()].sort((a, b) => b.level - a.level || a.side.localeCompare(b.side) || a.id - b.id);
	return {
		flags: [...byKey.values()],
		census: census && { sessions: census.sessions, cleared: list.filter((s) => !s.threat), added: list.filter((s) => s.threat) },
	};
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

module.exports = { levelsOf, sweep, compare, flagGoal, flagGrind, threatTo, readCensus, KINDS, GATE_MARGIN, CENSUS_MIN, R, RARE_R };
