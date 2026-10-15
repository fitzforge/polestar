'use strict';
// Resolver: turns a parsed guide into the compiled structure of
// docs/ARCHITECTURE.md ("Guide data"), filling titles, names, entities,
// coordinates, objective indexes and counts from reference data
// (docs/GUIDE_FORMAT.md, "What the compiler fills in").
//
// resolveGuide(ast, data, diag, { pack, author }) -> guide (`author`: the pack's, for a guide without one)
// Compiled goals and steps carry non-enumerable `_line` (source line) for the
// validator; everything enumerable is part of the compiled schema.

const SPAWN_CHECK_YARDS = 50;
// The fix hint for an id that is not in the reference data.
const FIND_ID_HINT = 'find the id with `polestar find <name>`, or give its name in quotes';

const { buildCandidates } = require('./candidates');
const { farmSpots } = require('./farmspots');
const { applicable, raceSides } = require('./conditions');
const { objectiveLabel } = require('./data');
const { checkLocation } = require('./places');
const { blockingPrereqs } = require('../data/prereqs');
const { clusterPoints, scaleOf } = require('../questdb/cluster');
const { groupOf } = require('./group');

// A collect's sources are named only for an item that few creatures or
// objects drop (at 2% or more, with spawns); past this it drops everywhere.
const MAX_NAMED_SOURCES = 8;

// Standard rank caps and the skill each rank can first be trained at (Classic).
const RANK_CAPS = [75, 150, 225, 300];
const RANK_MIN_SKILL = [0, 50, 125, 225];
const RANK_NAMES = ['Apprentice', 'Journeyman', 'Expert', 'Artisan'];

function round2(n) {
	const r = Math.round(n * 100) / 100;
	return Object.is(r, -0) ? 0 : r;
}

function hidden(obj, key, value) {
	Object.defineProperty(obj, key, { value, enumerable: false, writable: true, configurable: true });
	return obj;
}

function setIf(obj, key, value) {
	if (value !== undefined && value !== null && value !== '') obj[key] = value;
}

function nameOf(data, kind, id) {
	const e = kind === 'npc' ? data.npc(id) : kind === 'object' ? data.object(id) : kind === 'item' ? data.item(id) : null;
	return e && e.name ? String(e.name) : null;
}

// Distance between two points on one map: yards when the map's size is
// known, else map percent.
function distance(data, map, ax, ay, bx, by) {
	const size = data.mapSize(map);
	const dx = (ax - bx) * (size ? size.w / 100 : 1);
	const dy = (ay - by) * (size ? size.h / 100 : 1);
	return Math.sqrt(dx * dx + dy * dy);
}

// Pick an entity and a point for it. candidates: [{ kind, id }] in priority
// order (e.g. by drop chance). -> { cand, map, x, y, f, sources } | { cand } (no
// usable spawns) | null (no candidates). `sources`: the candidates the point
// was chosen among on its map (the likely droppers there).
//
// Maps are tried in this order: the current zone, then maps the guide has
// already used (most recent first). On the first map where any candidate
// spawns, the spawn nearest the previous goal wins when that goal is on the
// same map; otherwise the centroid of the highest-priority candidate there.
// Only when no candidate spawns on any of those maps does the first candidate
// with spawns fall back to its largest map.
function pickSpawn(data, candidates, zoneMap, prev, opts = {}) {
	if (!candidates.length) return null;
	const all = candidates.map((cand) => ({ cand, spawns: data.spawns(cand.kind, cand.id) }));
	const centroid = (cand, s) => {
		let sx = 0;
		let sy = 0;
		for (const p of s.pts) {
			sx += p[0];
			sy += p[1];
		}
		return point(cand, s.map, sx / s.pts.length, sy / s.pts.length, s.f);
	};
	const maps = [];
	if (zoneMap != null) maps.push(zoneMap);
	for (const m of opts.usedMaps || []) if (!maps.includes(m)) maps.push(m);
	for (const m of maps) {
		const on = onMap(all, m);
		if (!on.length) continue;
		if (prev && prev.map === m) {
			let best = null;
			for (const { cand, s } of on) {
				for (const p of s.pts) {
					const d = distance(data, m, p[0], p[1], prev.x, prev.y);
					if (!best || d < best.d) best = { d, cand, x: p[0], y: p[1], f: s.f };
				}
			}
			return { ...point(best.cand, m, best.x, best.y, best.f), sources: on.map((o) => o.cand) };
		}
		return { ...centroid(on[0].cand, on[0].s), sources: on.map((o) => o.cand) };
	}
	for (const { cand, spawns } of all) {
		if (!spawns.length) continue;
		const s = spawns.reduce((a, b) => (b.pts.length > a.pts.length ? b : a));
		return { ...centroid(cand, s), sources: [cand] };
	}
	return { cand: candidates[0] };
}

// The candidates ([{ cand, spawns }]) that spawn on `map`, with their spawns
// there: [{ cand, s }]. Sources with a drop chance: only the likely ones count
// (at least half the best chance here; sub-1% drops only when nothing better
// drops here).
function onMap(all, map) {
	const on = [];
	for (const { cand, spawns } of all) {
		const s = spawns.find((sp) => sp.map === map);
		if (s) on.push({ cand, s });
	}
	if (on.some((o) => typeof o.cand.chance === 'number')) {
		const best = Math.max(...on.map((o) => o.cand.chance || 0));
		const likely = on.filter((o) => (o.cand.chance || 0) >= best / 2 && ((o.cand.chance || 0) >= 1 || best < 1));
		if (likely.length) return likely;
	}
	return on;
}

function point(cand, map, x, y, f) {
	return { cand, map, x: round2(x), y: round2(y), f: f === 'e' ? 'e' : undefined };
}

// Spawn areas of a goal whose target is an npc or object (docs/GUIDE_FORMAT.md,
// "Spawn areas"): the spawns of its sources on the goal's map and in its frame,
// clustered with the quest database's clusterPoints. Every spawn lies in a
// spot: the ones the arrow picks by itself come first, the rest follow as
// alternatives (`alt = true`), which the world map marks and the arrow button
// reaches, so a player who finds no target where the arrow led can try every
// other place it spawns. Fewer than two spawns there: none (a single spawn
// stays a point).
//
// Places: a target with at most SPOT_CAP spawns is found at one of a few
// places (a named NPC or a quest object that appears at one of them, or the
// handful of mobs the objective needs), so every place is a spot the arrow
// may pick: spawns within SPOT_CLUSTER_YARDS of each other are one place, at
// least SPOT_MIN_RADIUS wide. Places that reach further than SPREAD_YARDS are
// searched (`spread`, a walk from the goal's point); closer ones are camps,
// nearest to the goal's point first.
//
// Otherwise the cluster radius is the quest database's 70 yd, widened for
// targets that spawn far apart to twice the median spacing between
// neighbouring spawns (at most SPOT_MAX_CLUSTER_YARDS).
//
// Camps: 90% of the spawns within SPREAD_YARDS of their centre. The arrow
// picks among the clusters of two or more spawns (all clusters when none has
// two), nearest to the goal's point first, at most SPOT_CAP; lone spawns and
// clusters past the cap are alternatives.
//
// Area objectives (`spread`): the spawns reach further. Every cluster counts,
// lone spawns too, each at least as wide as the spacing between spawns
// (SPREAD_MIN_RADIUS..SPREAD_MAX_MIN_RADIUS); beyond SPREAD_CAP the searched
// ones are spread evenly over the area (farthest-point picks, from the cluster
// nearest the goal's point), ordered as a walk from the goal's point (each
// next spot the nearest one not yet in the walk); the others are alternatives.
//
// Alternatives come nearest to the goal's point first.
//
// -> { spots: [{ x, y, r, n, alt? }], spread: bool } (map percent, radius in
// yards, spawn count) | undefined
const SPOT_CAP = 6;
const SPOT_CLUSTER_YARDS = 70;
const SPOT_MAX_CLUSTER_YARDS = 250;
const SPOT_MIN_RADIUS = 15;
const SPREAD_YARDS = 250;
const SPREAD_CAP = 12;
const SPREAD_MIN_RADIUS = 40;
const SPREAD_MAX_MIN_RADIUS = 150;

// Median distance in yards from a spawn to its nearest neighbour.
function medianSpacing(pts, frame) {
	const { sx, sy } = scaleOf(frame);
	const nn = pts.map((p, i) => {
		let best = Infinity;
		for (let j = 0; j < pts.length; j++) {
			if (j === i) continue;
			const d = Math.hypot((p[0] - pts[j][0]) * sx, (p[1] - pts[j][1]) * sy);
			if (d < best) best = d;
		}
		return best;
	});
	nn.sort((a, b) => a - b);
	return nn[Math.floor(nn.length / 2)];
}

// Yards from the spawns' centre within which 90% of them lie.
function extent90(pts, frame) {
	const { sx, sy } = scaleOf(frame);
	let cx = 0;
	let cy = 0;
	for (const p of pts) {
		cx += p[0] / pts.length;
		cy += p[1] / pts.length;
	}
	const ds = pts.map((p) => Math.hypot((p[0] - cx) * sx, (p[1] - cy) * sy)).sort((a, b) => a - b);
	return ds[Math.min(ds.length - 1, Math.floor(ds.length * 0.9))];
}

// Up to `cap` clusters spread evenly: start from the one nearest (x, y), then
// repeatedly the one farthest from every pick (ties: more spawns, then position).
function evenly(data, map, clusters, cap, x, y) {
	if (clusters.length <= cap) return clusters.slice();
	const dist = (a, b) => distance(data, map, a.x, a.y, b.x, b.y);
	const here = { x, y };
	const tie = (a, b) => b.n - a.n || a.x - b.x || a.y - b.y;
	const rest = clusters.slice().sort((a, b) => dist(a, here) - dist(b, here) || tie(a, b));
	const picked = [rest.shift()];
	const gap = new Map(rest.map((c) => [c, dist(c, picked[0])]));
	while (picked.length < cap && rest.length) {
		let bi = 0;
		for (let i = 1; i < rest.length; i++) {
			const d = gap.get(rest[i]) - gap.get(rest[bi]);
			if (d > 0 || (d === 0 && tie(rest[i], rest[bi]) < 0)) bi = i;
		}
		const next = rest.splice(bi, 1)[0];
		picked.push(next);
		for (const c of rest) gap.set(c, Math.min(gap.get(c), dist(c, next)));
	}
	return picked;
}

// The spots as a walk from (x, y): each next one the nearest left.
function walk(data, map, spots, x, y) {
	const left = spots.slice();
	const out = [];
	let at = { x, y };
	while (left.length) {
		let bi = 0;
		for (let i = 1; i < left.length; i++) {
			const d = distance(data, map, left[i].x, left[i].y, at.x, at.y) - distance(data, map, left[bi].x, left[bi].y, at.x, at.y);
			if (d < 0 || (d === 0 && (left[i].n > left[bi].n || (left[i].n === left[bi].n && (left[i].x - left[bi].x || left[i].y - left[bi].y) < 0)))) bi = i;
		}
		at = left.splice(bi, 1)[0];
		out.push(at);
	}
	return out;
}

// Every known spawn point of `sources` on `map` in frame `f`: the reference
// data's spread points and the ones its cap left out.
function spawnPointsOf(data, sources, map, f) {
	const pts = [];
	for (const src of sources) {
		for (const s of data.spawns(src.kind, src.id)) {
			if (s.map === map && (s.f === 'e' ? 'e' : undefined) === f) pts.push(...s.pts, ...s.more);
		}
	}
	return pts;
}

// A gathering node (mine, herb or fishing object): the real source of what
// it yields at any chance.
const GATHER_ROLES = ['mine', 'herb', 'fishing'];
function gatherNode(data, src) {
	const o = src.kind === 'object' ? data.object(src.id) : null;
	return !!(o && Array.isArray(o.roles) && o.roles.some((r) => GATHER_ROLES.includes(r)));
}

function spawnSpots(data, sources, map, f, x, y) {
	const pts = spawnPointsOf(data, sources, map, f);
	if (pts.length < 2) return undefined;
	const frame = data.eraFrame(map);
	const spread = extent90(pts, frame) > SPREAD_YARDS;
	const nearestFirst = (spots) => {
		const d = new Map(spots.map((s) => [s, distance(data, map, s.x, s.y, x, y)]));
		return spots.sort((a, b) => d.get(a) - d.get(b) || b.n - a.n || a.x - b.x || a.y - b.y);
	};
	// The clusters the arrow picks from first, then every other one as an alternative.
	const withRest = (picked, clusters) => [...picked, ...nearestFirst(clusters.filter((c) => !picked.includes(c))).map((c) => ({ ...c, alt: true }))];
	if (pts.length <= SPOT_CAP) {
		const places = clusterPoints(pts, frame, { radius: SPOT_CLUSTER_YARDS, cap: Infinity, minRadius: SPOT_MIN_RADIUS });
		return spread ? { spots: walk(data, map, places, x, y), spread: true } : { spots: nearestFirst(places), spread: false };
	}
	const spacing = medianSpacing(pts, frame);
	const radius = Math.min(SPOT_MAX_CLUSTER_YARDS, Math.max(SPOT_CLUSTER_YARDS, 2 * spacing));
	if (spread) {
		const minRadius = Math.round(Math.min(SPREAD_MAX_MIN_RADIUS, Math.max(SPREAD_MIN_RADIUS, spacing)));
		const clusters = clusterPoints(pts, frame, { radius, cap: Infinity, minRadius });
		return { spots: withRest(walk(data, map, evenly(data, map, clusters, SPREAD_CAP, x, y), x, y), clusters), spread: true };
	}
	const clusters = clusterPoints(pts, frame, { radius, cap: Infinity, minRadius: SPOT_MIN_RADIUS });
	const camps = clusters.some((s) => s.n > 1) ? clusters.filter((s) => s.n > 1) : clusters;
	return { spots: withRest(nearestFirst(camps).slice(0, SPOT_CAP), clusters), spread: false };
}

// A hand-placed goal (`@x,y`) whose target spawns at several places: the
// author's point is the spot the arrow takes, and every place the data knows
// is an alternative (a place within SPOT_MIN_RADIUS of the point joins it,
// the point's radius growing to cover that place's spawns; when every place
// joins, the point is the goal's only spot). Only while the point lies where
// the data has the target, within `near` yards of a known spawn: a point
// further from every spawn places the target where the data does not (Forever
// moved it), and the data's places would mislead.
// -> spots | undefined
function handSpots(data, sources, map, f, x, y, near) {
	if (!data.mapSize(map)) return undefined;
	const pts = spawnPointsOf(data, sources, map, f);
	if (!pts.some((p) => distance(data, map, p[0], p[1], x, y) <= near)) return undefined;
	const sp = spawnSpots(data, sources, map, f, x, y);
	if (!sp) return undefined;
	const own = { x, y, r: SPOT_MIN_RADIUS, n: 0 };
	const alts = [];
	for (const s of sp.spots) {
		const d = distance(data, map, s.x, s.y, x, y);
		if (d <= s.r + SPOT_MIN_RADIUS) {
			own.r = Math.max(own.r, Math.ceil(d + s.r));
			own.n += s.n;
		} else alts.push({ x: s.x, y: s.y, r: s.r, n: s.n, alt: true, d });
	}
	alts.sort((a, b) => a.d - b.d || a.x - b.x || a.y - b.y);
	return [own, ...alts.map(({ d, ...s }) => s)];
}

function onlyOf(c) {
	if (!c) return undefined;
	const o = {};
	setIf(o, 'classes', c.classes);
	setIf(o, 'races', c.races);
	setIf(o, 'factions', c.factions);
	return Object.keys(o).length ? o : undefined;
}

// A parsed `when` predicate with its profession/faction names resolved to ids
// (a new AST; the parsed one is not mutated). Returns null when a name is
// unknown; every unknown name is reported through `report`.
function resolvePredicate(node, data, report) {
	if (Array.isArray(node) && (node[0] === 'skill' || node[0] === 'rep') && typeof node[1] === 'string') {
		if (node[0] === 'skill') {
			const p = data.professionNamed(node[1]);
			if (!p) {
				report(`unknown profession "${node[1]}"`);
				return null;
			}
			return ['skill', p.id, node[2], node[3]];
		}
		const f = data.factionNamed(node[1]);
		if (!f) {
			report(`unknown faction "${node[1]}"`);
			return null;
		}
		return ['rep', f.faction.id, node[2], node[3]];
	}
	if (Array.isArray(node) && (node[0] === 'all' || node[0] === 'any' || node[0] === 'not')) {
		const out = [node[0]];
		let failed = false;
		for (let i = 1; i < node.length; i++) {
			const child = resolvePredicate(node[i], data, report);
			if (child === null) failed = true;
			else out.push(child);
		}
		return failed ? null : out;
	}
	if (Array.isArray(node)) return node.map((x) => (Array.isArray(x) ? x.slice() : x));
	return node;
}

// Warn for quest and item ids a `when` names that are not in the reference
// data, like goal ids are (docs/GUIDE_FORMAT.md, "Validation"). Each distinct
// id is warned once per `when` line.
function checkPredicateIds(node, data, report) {
	const haveItems = Object.keys(data.items || {}).length > 0;
	const seen = new Set();
	const walk = (n) => {
		if (!Array.isArray(n)) return;
		const kind = n[0];
		if (kind === 'onquest' || kind === 'ready' || kind === 'turnedin') {
			const q = n[1];
			if (!seen.has(`quest ${q}`)) {
				seen.add(`quest ${q}`);
				if (!data.quest(q)) report(`\`when\`: quest ${q} is not in data (new Forever content?)`);
			}
			return;
		}
		if (kind === 'item') {
			const i = n[1];
			if (haveItems && !seen.has(`item ${i}`)) {
				seen.add(`item ${i}`);
				if (!data.item(i)) report(`\`when\`: item ${i} is not in data (new Forever content?)`);
			}
			return;
		}
		if (kind === 'all' || kind === 'any' || kind === 'not') {
			for (let i = 1; i < n.length; i++) walk(n[i]);
		}
	};
	walk(node);
}

function resolveGuide(ast, data, diag, opts = {}) {
	const file = ast.file;
	const err = (ln, msg, hint) => diag.error(file, ln, msg, hint);
	const warn = (ln, msg, hint) => diag.warn(file, ln, msg, hint);
	const h = ast.header;
	const zoneCache = new Map();

	const resolveZone = (spec) => {
		if (!spec) return null;
		if (zoneCache.has(spec)) return zoneCache.get(spec);
		let out = null;
		if (spec.map !== undefined) {
			const z = data.zone(spec.map);
			if (!z && Object.keys(data.zones).length) warn(spec.line, `map ${spec.map} is not in zones.json`);
			out = { id: spec.map, name: z && z.name ? String(z.name) : undefined };
		} else {
			const found = data.zoneNamed(spec.name);
			if (!found) {
				err(spec.line, `unknown zone "${spec.name}" (not in zones.json; use \`zone map <uiMapID>\`)`);
			} else {
				if (found.ambiguous) {
					warn(spec.line, `zone "${spec.name}" matches maps ${found.ambiguous.map((z) => z.id).join(', ')}; using ${found.zone.id} (write \`zone map <uiMapID>\` to choose)`);
				}
				out = { id: found.zone.id, name: String(found.zone.name) };
			}
		}
		zoneCache.set(spec, out);
		return out;
	};

	const guide = { id: ast.id };
	guide.pack = opts.pack || 'guides';
	guide.title = h.title;
	setIf(guide, 'faction', h.faction);
	setIf(guide, 'races', h.races);
	setIf(guide, 'classes', h.classes);
	if (h.levels) {
		guide.minLevel = h.levels.min;
		guide.maxLevel = h.levels.max;
	}
	guide.category = canonicalCategory(h.category, ast, warn);
	setIf(guide, 'folder', h.folder);
	setIf(guide, 'keywords', h.keywords);
	if (h.collects) {
		guide.collects = h.collects.slice();
		// Validated only when items.json is loaded: a missing data directory already warns.
		const haveItems = Object.keys(data.items || {}).length > 0;
		for (const id of h.collects) {
			if (haveItems && !data.item(id)) warn(ast.lines.collects, `\`collects\` item ${id} is not in data (new Forever content?)`);
		}
	}
	// `reward` / `why`: what the guide's goal gives and why it is worth it,
	// shown in the guide menu. Display only: an item's name from the line,
	// else items.json (an id with neither is an error); a spell needs its name.
	if (h.reward) {
		guide.reward = h.reward.map((e) => {
			if (e.text !== undefined) return { text: e.text };
			if (e.spell !== undefined) {
				if (!e.spellName) err(e.line, `reward spell ${e.spell} needs its name: \`reward spell ${e.spell} "Spell name"\``);
				return { spell: e.spell, spellName: e.spellName };
			}
			const known = data.item(e.item);
			const out = { item: e.item };
			const name = e.itemName || (known && known.name ? String(known.name) : null);
			if (!name) err(e.line, `reward item ${e.item} is not in data; give its name: \`${e.item} "Item name"\``, FIND_ID_HINT);
			else out.itemName = name;
			setIf(out, 'quality', e.quality);
			if (e.choice) out.choice = true;
			return out;
		});
	}
	setIf(guide, 'why', h.why);
	if (guide.category === 'Class') {
		if (!h.reward) warn(ast.line, 'a Class guide needs `reward`: what its chain gives (`reward item <id>`, `reward spell <id> "Name"` or `reward text <words>`), shown in the guide menu');
		if (!h.why) warn(ast.line, 'a Class guide needs `why`: one short line on why the chain is worth doing, shown in the guide menu');
	}
	const hz = resolveZone(h.zone);
	if (hz) {
		guide.zone = hz.id;
		setIf(guide, 'zoneName', hz.name);
	}
	// `next`: the default route; with several, `nextChoices` lists every
	// option in the author's order (the default first) for the route choice.
	if (h.next && h.next.length) {
		guide.next = h.next[0];
		if (h.next.length > 1) guide.nextChoices = h.next.slice();
	}
	setIf(guide, 'pitch', h.pitch);
	setIf(guide, 'pros', h.pros);
	setIf(guide, 'cons', h.cons);
	// A guide without `author` is its pack's author's (opts.author, from
	// pack.json); ours when no pack author is given.
	guide.author = h.author || opts.author || 'Polestar';
	guide.version = h.version !== undefined ? h.version : 1;
	guide.steps = [];
	hidden(guide, '_ast', ast);

	// Every zone the guide sets anywhere (header and `zone` directives).
	const zonesSet = new Set();
	if (hz) zonesSet.add(hz.id);
	for (const s of ast.steps) {
		for (const g of s.goals) {
			const z = resolveZone(g.zone);
			if (z) zonesSet.add(z.id);
		}
	}

	let prev = null;
	const usedMaps = []; // most recent first
	const use = (m) => {
		const i = usedMaps.indexOf(m);
		if (i >= 0) usedMaps.splice(i, 1);
		usedMaps.unshift(m);
	};
	const frameDefault = { frame: h.coords || 'era', explicit: h.coords !== undefined };
	// Per skill line, in step order: the last `skill`/`until` target and the last rank trained.
	const profProgress = new Map();
	for (const s of ast.steps) {
		const step = {};
		setIf(step, 'title', s.title);
		setIf(step, 'note', s.tip);
		setIf(step, 'only', onlyOf(s.only));
		if (s.when) {
			const w = resolvePredicate(s.when, data, (msg) => err(s.whenLine, msg));
			if (w) {
				step.when = w;
				checkPredicateIds(w, data, (msg) => warn(s.whenLine, msg));
			}
		}
		setIf(step, 'label', s.label);
		if (s.along !== undefined) step.along = s.along;
		if (s.skips) {
			const out = [];
			for (const sk of s.skips) {
				const w = resolvePredicate(sk.when, data, (msg) => err(sk.line, msg));
				if (w) {
					checkPredicateIds(w, data, (msg) => warn(sk.line, msg));
					out.push({ to: sk.to, when: w });
				}
			}
			if (out.length) step.skips = out;
		}
		step.goals = [];
		hidden(step, '_line', s.line);
		hidden(step, '_only', s.only);
		for (const g of s.goals) {
			const zone = resolveZone(g.zone);
			const zoneId = zone ? zone.id : null;
			const ctx = {
				sides: sidesFor([h.faction ? [h.faction] : null, s.only && s.only.factions, g.only && g.only.factions]),
				usedMaps,
				frame: g.frame ? { frame: g.frame, explicit: true } : frameDefault,
				layers: [{ factions: h.faction ? [h.faction] : null, races: h.races || null, classes: h.classes || null }, s.only, g.only],
				prof: profProgress,
				zoneId,
			};
			const goal = resolveGoal(g, zoneId, prev, data, err, warn, ctx);
			hidden(goal, '_line', g.line);
			hidden(goal, '_only', g.only || null);
			step.goals.push(goal);
			// Leveling guides are for every character: a goal only those with a
			// profession see should be optional, unless the guide trains it first
			// (and levels it to the quest's rank above 1).
			if (guide.category === 'Leveling' && goal.profLine !== undefined && !goal.optional) {
				const prog = profProgress.get(goal.profLine);
				if (!prog || !(prog.target >= goal.profRank || (prog.rank >= 1 && goal.profRank <= 1))) {
					const prof = `${goal.profName || `skill ${goal.profLine}`} ${goal.profRank}`;
					warn(
						g.line,
						`quest ${goal.quest} (${goal.title || 'untitled'}) needs ${prof}, and the guide does not train it before here: characters without it never see this goal`,
						`make the goal \`optional\`, or \`train ${goal.profName || '<Profession>'}\` earlier in the guide`,
					);
				}
			}
			if (goal.map !== undefined && zoneId !== null && goal.map !== zoneId && !zonesSet.has(goal.map)) {
				const name = (id) => {
					const z = data.zone(id);
					return z && z.name ? `${id} (${z.name})` : String(id);
				};
				warn(
					g.line,
					`coordinates on map ${name(goal.map)}, but this step's zone is ${name(zoneId)} and the guide never sets zone ${goal.map}; check the target, or add \`zone map ${goal.map}\` if the route really goes there`,
				);
			}
			if (zoneId !== null) use(zoneId);
			if (goal.x !== undefined) {
				prev = { map: goal.map, x: goal.x, y: goal.y };
				use(goal.map);
			}
		}
		guide.steps.push(step);
	}
	// The guide menu's "Group" chip: some goal of the route needs a group.
	if (guide.steps.some((s) => s.goals.some((goal) => goal.group && !goal.optional))) guide.group = true;
	// Labels are guide-wide: names must be unique, and an `along until` must
	// point at a step later than the one using it (indexes match ast.steps —
	// every step is pushed as it is built).
	const labels = new Map(); // name -> { index, line }
	for (let i = 0; i < ast.steps.length; i++) {
		const s = ast.steps[i];
		if (!s.label) continue;
		if (labels.has(s.label)) err(s.labelLine, `duplicate label "${s.label}" (first at line ${labels.get(s.label).line})`);
		else labels.set(s.label, { index: i, line: s.labelLine });
	}
	for (let i = 0; i < ast.steps.length; i++) {
		const s = ast.steps[i];
		if (typeof s.along !== 'string') continue;
		const t = labels.get(s.along);
		if (!t) err(s.alongLine, `unknown label "${s.along}"`);
		else if (t.index <= i) err(s.alongLine, `\`along until ${s.along}\` must name a later step`);
	}
	// `skipto <label>` must name a later step; a `done <label>` in a condition
	// must name a labelled step anywhere in the guide.
	for (let i = 0; i < ast.steps.length; i++) {
		const s = ast.steps[i];
		for (const sk of s.skips || []) {
			const t = labels.get(sk.to);
			if (!t) err(sk.line, `unknown label "${sk.to}"`);
			else if (t.index <= i) err(sk.line, `\`skipto ${sk.to}\` must name a later step`);
		}
		for (const l of doneLabels(s.when)) {
			if (!labels.has(l)) err(s.whenLine, `\`when\`: unknown label "${l}"`);
		}
		for (const sk of s.skips || []) {
			for (const l of doneLabels(sk.when)) {
				if (!labels.has(l)) err(sk.line, `\`skipto\`: unknown label "${l}"`);
			}
		}
	}
	return guide;
}

// The labels a predicate AST names through `done <label>` atoms.
function doneLabels(node) {
	if (!Array.isArray(node)) return [];
	if (node[0] === 'done') return [node[1]];
	if (node[0] === 'all' || node[0] === 'any') return node.slice(1).flatMap(doneLabels);
	if (node[0] === 'not') return doneLabels(node[1]);
	return [];
}

function objectiveFor(q, kind, id) {
	if (!q || !Array.isArray(q.objectives)) return null;
	const idx = q.objectives.findIndex((o) => o && o.id === id && (kind === null || o.type === kind));
	return idx < 0 ? null : idx + 1;
}

const CATEGORIES = ['Leveling', 'Class', 'Professions', 'Reputation', 'Legacy', 'Exploration', 'Collectibles', 'Dungeons'];

// Documented categories are matched case-insensitively; others pass through with a warning.
function canonicalCategory(raw, ast, warn) {
	if (raw === undefined) return 'Leveling';
	const known = CATEGORIES.find((c) => c.toLowerCase() === raw.toLowerCase());
	if (known) return known;
	warn(ast.lines.category, `unknown category "${raw}" (known: ${CATEGORIES.join(', ')})`);
	return raw;
}

// Factions a smart goal serves: the goal's factions, narrowed by the races it
// can apply to (a Human-only guide needs no Horde trainers). Skyborne and
// unknown races (new Forever races) keep both.
function smartSides(sides, chars) {
	const fromRaces = new Set(chars.races.flatMap(raceSides));
	const narrowed = sides.filter((s) => fromRaces.has(s));
	return narrowed.length ? narrowed : sides;
}

function progressOf(ctx, skillLine) {
	if (!ctx.prof) return { target: undefined, rank: 0 };
	if (!ctx.prof.has(skillLine)) ctx.prof.set(skillLine, { target: undefined, rank: 0 });
	return ctx.prof.get(skillLine);
}

// `train <Profession> [Rank]`. Without a rank: the highest rank whose minimum
// skill the guide's last `skill`/`until` target for that profession reaches
// (Apprentice when there is none), and always above a rank trained earlier in
// the guide.
function trainProfession(g, goal, data, ctx, err, warn, smart) {
	const ln = g.line;
	const p = data.professionNamed(g.profession);
	if (!p) {
		err(ln, `unknown profession "${g.profession}" (write \`train <Profession> [Apprentice|Journeyman|Expert|Artisan]\`, \`train class\` or \`train <npcId>\`)`);
		return;
	}
	const full = data.profession(p.id) || p;
	const ranks = Array.isArray(full.ranks) ? full.ranks : [];
	const minSkill = (r) => (ranks[r - 1] && Number.isFinite(Number(ranks[r - 1].minSkill)) ? Number(ranks[r - 1].minSkill) : RANK_MIN_SKILL[r - 1]);
	const prog = progressOf(ctx, p.id);
	let rank = g.rank;
	if (rank === undefined) {
		rank = 1;
		if (prog.target !== undefined) {
			for (let r = 4; r >= 1; r--) {
				if (minSkill(r) <= prog.target) {
					rank = r;
					break;
				}
			}
		}
		if (rank <= prog.rank) rank = prog.rank + 1;
		if (rank > 4) {
			err(ln, `\`train ${p.name}\`: Artisan is already trained earlier in this guide`);
			return;
		}
		const have = prog.target === undefined ? 0 : prog.target;
		if (minSkill(rank) > have) {
			warn(ln, `\`train ${p.name}\` means ${RANK_NAMES[rank - 1]} here (needs skill ${minSkill(rank)}), but no earlier \`skill ${p.name}\` target reaches ${minSkill(rank)}; name the rank or add the skill goal`);
		}
	}
	goal.skill = String(p.name);
	goal.skillLine = p.id;
	goal.rank = rank;
	goal.rankMax = ranks[rank - 1] && Number(ranks[rank - 1].max) > 0 ? Number(ranks[rank - 1].max) : RANK_CAPS[rank - 1];
	prog.rank = Math.max(prog.rank, rank);
	if (g.npc !== undefined) return; // an explicit trainer stays fixed
	const rk = ranks[rank - 1] || {};
	const entries = [];
	const addSides = (bySide) => {
		for (const side of Object.keys(bySide || {}).sort()) {
			const tag = side === 'Alliance' || side === 'A' ? 'A' : side === 'Horde' || side === 'H' ? 'H' : undefined;
			for (const id of Array.isArray(bySide[side]) ? bySide[side] : []) entries.push({ npc: Number(id), side: tag });
		}
	};
	let what = `${p.name} ${RANK_NAMES[rank - 1]} trainer`;
	if (rk.trainers) addSides(rk.trainers);
	else if (rk.book && rk.book.vendors) {
		addSides(rk.book.vendors);
		what = `vendor of the ${p.name} ${RANK_NAMES[rank - 1]} book`;
	} else if (rk.quest && rk.quest.npcs) {
		addSides(rk.quest.npcs);
		what = `${p.name} ${RANK_NAMES[rank - 1]} quest giver`;
	} else addSides(full.trainers);
	smart(goal, entries, `${what}${data.hasProfessions ? '' : ' (professions.json missing)'}`);
}

// Factions a goal can apply to, from the guide faction and step/goal conditions.
function sidesFor(lists) {
	let sides = ['Alliance', 'Horde'];
	for (const l of lists) if (l) sides = sides.filter((s) => l.includes(s));
	return sides;
}

function resolveGoal(g, zoneMap, prev, data, err, warn, ctx = { sides: ['Alliance', 'Horde'] }) {
	const ln = g.line;
	const v = g.verb;
	const goal = { t: v };
	let candidates = []; // entities whose spawns give coordinates
	let checkKinds = null; // entities for the explicit-coordinates check
	let questFields = false;

	const requireName = (kind, id, explicit, label) => {
		const name = explicit || nameOf(data, kind, id);
		const known = kind === 'npc' ? data.npc(id) : kind === 'object' ? data.object(id) : data.item(id);
		if (!name) {
			err(ln, `${kind} ${id} is not in data; give its name: \`${v} ${id} "${label}"\``, FIND_ID_HINT);
		} else if (!known) {
			warn(ln, `${kind} ${id} is not in data; using the explicit name (new Forever content?)`);
		}
		return name;
	};
	const optionalName = (kind, id) => {
		const name = nameOf(data, kind, id);
		const known = kind === 'npc' ? data.npc(id) : kind === 'object' ? data.object(id) : data.item(id);
		if (!known) warn(ln, `${kind} ${id} is not in data; its name and position cannot be filled`);
		return name;
	};
	// A location the game never reports (places.js): a warning with the closest names.
	const placeWarning = (verb, location) => {
		const bad = checkLocation(data, verb, location);
		if (bad) warn(ln, bad.message, bad.hint);
	};

	// Smart targets: a candidate set the engine chooses from at runtime, for
	// the factions this goal can apply to, ranked from the previous goal (else
	// the zone centre).
	const smart = (target, entries, what) => {
		const chars = applicable(ctx.layers || []);
		const sides = smartSides(ctx.sides, chars);
		const ref = prev || (ctx.zoneId != null ? { map: ctx.zoneId, x: 50, y: 50 } : null);
		const built = buildCandidates(data, entries, { sides, ref });
		if (!built.candidates.length) {
			err(ln, `\`${v}\` found no ${what} in data for ${sides.join(' or ')} characters; name one with an npc id instead`);
			return;
		}
		target.candidates = built.candidates;
		for (const s of sides) {
			if (!built.coverage[s]) warn(ln, `no ${what} for ${s} in data, but this goal applies to ${s} characters`);
		}
		if (target.class) {
			for (const s of sides) {
				for (const c of chars.classes) {
					// Only classes a race of this side can be (data/forever/races.json, the Forever client's CharBaseInfo).
					const possible = chars.races.some((r) => data.raceClasses(r, s).includes(c));
					if (!possible) continue;
					const tag = s === 'Alliance' ? 'A' : 'H';
					const has = built.candidates.some((cand) => (cand.faction === tag || cand.faction === 'AH') && (cand.classes || []).includes(c));
					if (!has) warn(ln, `no ${c[0]}${c.slice(1).toLowerCase()} trainer for ${s} in data (trainers.json)`);
				}
			}
		}
	};

	switch (v) {
		case 'accept':
		case 'turnin':
		case 'complete': {
			const q = data.quest(g.quest);
			goal.quest = g.quest;
			const title = g.title || (q && q.title ? String(q.title) : null);
			if (!title) err(ln, `quest ${g.quest} is not in data; give its title: \`${v} ${g.quest} "Title"\``, FIND_ID_HINT);
			else if (!q) warn(ln, `quest ${g.quest} is not in data; using the explicit title (new Forever content?)`);
			goal.title = title || undefined;
			if (v === 'complete') break;
			const ends = v === 'accept' ? q && q.start : q && q.end;
			if (g.npc !== undefined) {
				candidates = [{ kind: 'npc', id: g.npc }];
				optionalName('npc', g.npc);
			} else if (g.object !== undefined) {
				candidates = [{ kind: 'object', id: g.object }];
				optionalName('object', g.object);
			} else if (g.item !== undefined) {
				goal.item = g.item;
				setIf(goal, 'itemName', optionalName('item', g.item));
			} else if (ends) {
				for (const id of ends.npc || []) candidates.push({ kind: 'npc', id });
				for (const id of ends.object || []) candidates.push({ kind: 'object', id });
				if (!candidates.length && v === 'accept' && (ends.item || []).length) {
					goal.item = ends.item[0];
					setIf(goal, 'itemName', nameOf(data, 'item', goal.item));
				}
			}
			if (v === 'accept') {
				const ml = g.minLevel !== undefined ? g.minLevel : q && q.minLevel > 0 ? q.minLevel : undefined;
				setIf(goal, 'minLevel', ml);
				// For the engine's grey-quest skipping.
				if (q && Number(q.level) > 0) goal.qlvl = Number(q.level);
				// Blocking prerequisites only (breadcrumbs dropped): `pre` = one of
				// them suffices, `preAll` = every one is needed.
				const { all, any } = blockingPrereqs(q, (id) => data.quest(id));
				if (any.length) goal.pre = any;
				if (all.length) goal.preAll = all;
				// Quests that close this one for good once taken or done: the quest a
				// breadcrumb leads to, and its exclusive group (another race's or
				// class's version of the same chain).
				const closedBy = [];
				for (const id of [Number(q && q.breadcrumbFor), ...((q && q.excl) || []).map(Number)]) {
					if (Number.isInteger(id) && id > 0 && id !== goal.quest && !closedBy.includes(id)) closedBy.push(id);
				}
				if (closedBy.length) goal.closedBy = closedBy;
				// Titles for the engine's "needs <quest> first" / "you took <quest>" text.
				const titles = {};
				for (const id of [...all, ...any, ...closedBy]) {
					const pq = data.quest(id);
					if (pq && pq.title) titles[id] = String(pq.title);
				}
				if (Object.keys(titles).length) goal.preTitles = titles;
			}
			if (v === 'turnin') {
				const rewards = {};
				// Display only: names and qualities from the line, else items.json;
				// an id with neither name is an error, an unknown named id is fine.
				const entries = (list) =>
					list.map((it) => {
						const known = data.item(it.item);
						const out = { item: it.item };
						const name = it.itemName || (known && known.name ? String(known.name) : null);
						if (!name) err(ln, `reward item ${it.item} is not in data; give its name: \`${it.item} "Item name"\``, FIND_ID_HINT);
						else out.itemName = name;
						const quality = it.quality !== undefined ? it.quality : known && Number.isInteger(known.quality) ? known.quality : undefined;
						setIf(out, 'quality', quality);
						return out;
					});
				if (g.rewardItems) rewards.items = entries(g.rewardItems);
				if (g.rewardChoices) rewards.choices = entries(g.rewardChoices);
				if (g.rewardXp !== undefined) rewards.xp = g.rewardXp;
				if (g.rewardMoney !== undefined) rewards.money = g.rewardMoney;
				if (Object.keys(rewards).length) goal.rewards = rewards;
			}
			checkKinds = candidates;
			break;
		}
		case 'kill': {
			if (g.npc !== undefined) {
				goal.target = requireName('npc', g.npc, g.target, 'Target name') || undefined;
				goal.npc = g.npc;
				candidates = [{ kind: 'npc', id: g.npc }];
			} else {
				goal.target = g.target;
			}
			questFields = true;
			checkKinds = candidates;
			break;
		}
		case 'collect': {
			goal.item = g.item;
			goal.itemName = requireName('item', g.item, g.itemName, 'Item name') || undefined;
			const it = data.item(g.item);
			const sources = [];
			if (it && it.drops) {
				for (const kind of ['npc', 'object']) {
					for (const [id, chance] of Object.entries(it.drops[kind] || {})) sources.push({ kind, id: Number(id), chance: Number(chance) || 0 });
				}
			}
			sources.sort((a, b) => b.chance - a.chance || (a.kind === b.kind ? a.id - b.id : a.kind === 'npc' ? -1 : 1));
			// Every dropping source with spawns, by drop chance; pickSpawn prefers ones on
			// the current zone and on maps the guide already uses, then the likely sources
			// on that map (see pickSpawn), nearest first. Vendors are not sources here:
			// `buy … nearest` is the vendor path.
			if (g.nearest) {
				// Farm spots: the engine picks one by level, safety and travel time.
				if (g.quest !== undefined) err(ln, '`collect … nearest` farms by bag count; drop `quest` (quest objectives use the quest’s own targets)');
				if (g.count === undefined) err(ln, '`collect … nearest` needs a count: `collect <item> xN nearest`');
				const chars = applicable(ctx.layers || []);
				const sides = smartSides(ctx.sides, chars);
				const spots = farmSpots(data, g.item).filter((sp) => sides.some((s) => sp.faction === 'AH' || sp.faction === (s === 'Alliance' ? 'A' : 'H')));
				if (!spots.length) {
					err(ln, `\`collect ${g.item} nearest\` found no farm spot (normal mobs dropping it at 2% or more, outside towns) for ${sides.join(' or ')} characters; give @x,y or a gathering step instead`);
				} else {
					goal.candidates = spots;
					for (const s of sides) {
						if (!spots.some((sp) => sp.faction === 'AH' || sp.faction === (s === 'Alliance' ? 'A' : 'H'))) {
							warn(ln, `no farm spot for item ${g.item} that is safe for ${s}, but this goal applies to ${s} characters`);
						}
					}
				}
				break;
			}
			candidates = sources.filter((s) => data.spawns(s.kind, s.id).length);
			// The sources that matter, named for the reading flow ("Kill Aean
			// Swiftriver (rare elite)", "Kill Grell or Grellkin"): the item's
			// game objective only says "Fel Moss: 0/8", so quest objectives get
			// them too. Named only when a single located source has it or one
			// drops it at 50% or more; a second of the same kind at 50% or more
			// is named beside it (`fromAlso`). Not for an item that drops all
			// over the world (cloth: hundreds of droppers, where a guard's 100%
			// says nothing about where to farm it). `fromFaction` lets the
			// engine tell an enemy from a friend of the character's faction.
			const widespread = candidates.filter((s) => s.chance >= 2).length > MAX_NAMED_SOURCES;
			if (!widespread && candidates.length && (candidates.length === 1 || candidates[0].chance >= 50)) {
				const top = candidates[0];
				const rec = top.kind === 'npc' ? data.npc(top.id) : data.object(top.id);
				if (rec && rec.name) {
					goal.from = String(rec.name);
					goal.fromKind = top.kind;
					if (top.kind === 'npc') {
						if (Number(rec.rank) > 0) goal.fromRank = Number(rec.rank);
						if (['A', 'H', 'AH'].includes(rec.faction)) goal.fromFaction = rec.faction;
					}
					const next = candidates[1];
					const nrec = next && next.kind === top.kind && next.chance >= 50 && (next.kind === 'npc' ? data.npc(next.id) : data.object(next.id));
					if (nrec && nrec.name && String(nrec.name) !== goal.from) goal.fromAlso = String(nrec.name);
				}
			}
			// The 50-yard check only compares with real sources: anything dropping the
			// item at 2% or more (a rare boss at 0.2% is not where it is farmed) and
			// gathering nodes at any chance (a gem from a Copper Vein is 1% per node, yet
			// the real source; a chest at 0.5% is not).
			checkKinds = sources.filter((s) => s.chance >= 2 || gatherNode(data, s));
			questFields = true;
			break;
		}
		case 'interact': {
			goal.object = g.object;
			goal.objName = requireName('object', g.object, g.objName, 'Object name') || undefined;
			candidates = [{ kind: 'object', id: g.object }];
			checkKinds = candidates;
			questFields = true;
			break;
		}
		case 'use': {
			goal.item = g.item;
			goal.itemName = requireName('item', g.item, g.itemName, 'Item name') || undefined;
			questFields = true;
			break;
		}
		case 'talk': {
			goal.npc = g.npc;
			goal.npcName = requireName('npc', g.npc, g.npcName, 'NPC name') || undefined;
			candidates = [{ kind: 'npc', id: g.npc }];
			checkKinds = candidates;
			break;
		}
		case 'sethome':
		case 'getfp':
		case 'train':
		case 'vendor': {
			if (g.location !== undefined) goal.location = g.location;
			if (g.location !== undefined && (v === 'sethome' || v === 'getfp')) placeWarning(v, g.location);
			if (v === 'train' && g.profession !== undefined) trainProfession(g, goal, data, ctx, err, warn, smart);
			if (v === 'train' && g.classTrain) {
				goal.class = true;
				const set = applicable(ctx.layers);
				const entries = data
					.classTrainers()
					.map((t) => ({ npc: t.id, classes: t.classes.filter((c) => set.classes.includes(c)) }))
					.filter((e) => e.classes.length);
				smart(goal, entries, `class trainer`);
			}
			if (g.nearest && v === 'sethome') smart(goal, data.npcsWithRole('innkeeper').map((id) => ({ npc: id })), 'innkeeper');
			// Sell junk and repair: every repairer also buys junk, a plain vendor may not repair.
			if (g.nearest && v === 'vendor') smart(goal, data.npcsWithRole('repair').map((id) => ({ npc: id })), 'repair vendor');
			if (g.npc !== undefined) {
				goal.npc = g.npc;
				if (g.npcName) {
					goal.npcName = g.npcName;
					if (!data.npc(g.npc)) warn(ln, `npc ${g.npc} is not in data; using the explicit name (new Forever content?)`);
				} else if ((v === 'train' || v === 'vendor') && !g.npcExplicit) {
					// `train <npcId> ["Name"]` / `vendor <npcId> ["Name"]` can be named, so a bare unknown id is an error.
					setIf(goal, 'npcName', requireName('npc', g.npc, null, 'NPC name'));
				} else {
					setIf(goal, 'npcName', optionalName('npc', g.npc));
				}
				candidates = [{ kind: 'npc', id: g.npc }];
				checkKinds = candidates;
			}
			break;
		}
		case 'hearth':
		case 'fly':
			goal.location = g.location;
			placeWarning(v, g.location);
			break;
		case 'buy': {
			goal.item = g.item;
			goal.itemName = requireName('item', g.item, g.itemName, 'Item name') || undefined;
			if (g.count !== undefined) goal.count = g.count;
			if (g.npc !== undefined) {
				optionalName('npc', g.npc);
				candidates = [{ kind: 'npc', id: g.npc }];
			} else if (g.nearest) {
				const it = data.item(g.item);
				smart(goal, ((it && it.vendors) || []).map((id) => ({ npc: Number(id) })), `vendor of item ${g.item}`);
			} else {
				const it = data.item(g.item);
				candidates = ((it && it.vendors) || []).slice().sort((a, b) => a - b).map((id) => ({ kind: 'npc', id }));
			}
			checkKinds = candidates;
			break;
		}
		case 'level':
			goal.level = g.level;
			break;
		case 'note':
			break;
		case 'goto':
			break;
		case 'skill': {
			const p = data.professionNamed(g.skill);
			if (p) {
				goal.skill = String(p.name);
				goal.skillLine = p.id;
			} else if (g.skillQuoted) {
				goal.skill = g.skill;
				warn(ln, `profession "${g.skill}" is not in data${data.hasProfessions ? '' : ' (professions.json missing)'}; using the explicit name (new Forever content?)`);
			} else {
				err(ln, `unknown profession "${g.skill}"; quote the name to use it anyway: \`skill "${g.skill}" ${g.level}\``);
			}
			goal.level = g.level;
			if (goal.skillLine !== undefined) progressOf(ctx, goal.skillLine).target = g.level;
			break;
		}
		case 'learn':
		case 'craft': {
			const found = data.recipe(g.spell);
			const r = found ? found.recipe : null;
			const where = data.hasProfessions ? '' : ' (professions.json missing)';
			goal.spell = g.spell;
			const name = g.spellName || (r && r.name ? String(r.name) : null);
			if (!name) err(ln, `spell ${g.spell} is not in data${where}; give its name: \`${v} ${g.spell} "Name"\``);
			else if (!found) warn(ln, `spell ${g.spell} is not in data${where}; using the explicit name (new Forever content?)`);
			goal.spellName = name || undefined;
			if (found) goal.skillLine = found.profession.id;
			if (v === 'learn') {
				const recipeItem = g.item !== undefined ? g.item : r && Number(r.recipeItem) > 0 ? Number(r.recipeItem) : undefined;
				if (recipeItem !== undefined) {
					goal.item = recipeItem;
					setIf(goal, 'itemName', g.item !== undefined ? optionalName('item', recipeItem) : nameOf(data, 'item', recipeItem));
				}
				if (g.npc !== undefined) {
					goal.npc = g.npc;
					setIf(goal, 'npcName', optionalName('npc', g.npc));
					candidates = [{ kind: 'npc', id: g.npc }];
					checkKinds = candidates;
				} else if (r && (r.source === 'trainer' || !r.source) && recipeItem === undefined && !g.explicitCoords) {
					// Trainer-taught: every trainer of the rank that teaches this skill level,
					// both factions tagged; the engine picks the nearest own-faction one.
					const prof = found.profession;
					const ranks = Array.isArray(prof.ranks) ? prof.ranks : [];
					const at = Number(r.learnedAt) || 0;
					const rank = ranks.find((rk) => rk && rk.trainers && Number(rk.max) >= at);
					const bySide = rank ? rank.trainers : prof.trainers || {};
					const entries = [];
					for (const side of Object.keys(bySide).sort()) {
						const tag = side === 'Alliance' ? 'A' : side === 'Horde' ? 'H' : undefined;
						for (const id of Array.isArray(bySide[side]) ? bySide[side] : []) entries.push({ npc: Number(id), side: tag });
					}
					smart(goal, entries, `${prof.name}${rank && rank.name ? ` ${rank.name}` : ''} trainer`);
				} else if (g.nearest && recipeItem !== undefined) {
					const it = data.item(recipeItem);
					smart(goal, ((it && it.vendors) || []).map((id) => ({ npc: Number(id) })), `vendor of item ${recipeItem}`);
				} else if (g.nearest) {
					err(ln, `\`learn ${g.spell} nearest\`: no trainer or recipe vendor for this spell in data`);
				}
			} else {
				const made = r && Number(r.item) > 0 ? Number(r.item) : null;
				if (made) {
					goal.item = made;
					setIf(goal, 'itemName', nameOf(data, 'item', made));
				}
				// `x<N>` counts crafts; the engine counts created items.
				if (g.count !== undefined) goal.count = g.count * (r && Number(r.itemCount) > 1 ? Number(r.itemCount) : 1);
				if (g.untilSkill !== undefined) {
					goal.untilSkill = g.untilSkill;
					if (found) progressOf(ctx, found.profession.id).target = g.untilSkill;
					if (!found) {
						warn(ln, `\`until\` needs the recipe's profession, but spell ${g.spell} is not in professions.json; the engine cannot check the skill`);
					} else if (Number(r.grey) > 0 && g.untilSkill > Number(r.grey)) {
						warn(ln, `${goal.spellName} turns grey at ${r.grey}; crafting it gives no skill up to ${g.untilSkill}`);
					}
				}
				if (r && Array.isArray(r.reagents) && r.reagents.length) {
					goal.reagents = r.reagents
						.filter((x) => x && Number(x.item) > 0)
						.map((x) => {
							const reagent = { item: Number(x.item) };
							setIf(reagent, 'itemName', nameOf(data, 'item', reagent.item));
							reagent.count = Number(x.count) > 0 ? Number(x.count) : 1;
							return reagent;
						});
				}
			}
			break;
		}
		case 'rep': {
			const where = data.hasFactions ? '' : ' (factions.json missing)';
			if (g.factionId !== undefined) {
				const f = data.faction(g.factionId);
				goal.faction = g.factionId;
				const name = g.factionName || (f && f.name ? String(f.name) : null);
				if (!name) err(ln, `faction ${g.factionId} is not in data${where}; give its name: \`rep ${g.factionId} "Name" <Standing>\``);
				else if (!f) warn(ln, `faction ${g.factionId} is not in data${where}; using the explicit name (new Forever content?)`);
				goal.factionName = name || undefined;
			} else {
				const found = data.factionNamed(g.factionName);
				if (found) {
					goal.faction = found.faction.id;
					goal.factionName = String(found.faction.name);
					if (found.ambiguous) {
						warn(ln, `faction "${g.factionName}" matches ids ${found.ambiguous.map((f) => f.id).join(', ')}; using ${found.faction.id} (write \`rep <factionId> <Standing>\` to choose)`);
					}
				} else {
					// The engine tracks reputation by faction id, so a name alone cannot work.
					goal.factionName = g.factionName;
					err(ln, `unknown faction "${g.factionName}"${where}; give its id with the name: \`rep <factionId> "${g.factionName}" <Standing>\``);
				}
			}
			goal.standing = g.standing;
			break;
		}
		case 'explore':
			break;
		case 'achieve':
			goal.achievement = g.achievement;
			// No achievement data exists, so the name always comes from the guide.
			if (!g.achievementName) err(ln, `achievement ${g.achievement} has no reference data; give its name: \`achieve ${g.achievement} "Name"\``);
			goal.achievementName = g.achievementName;
			if (g.criteria !== undefined) goal.criteria = g.criteria;
			break;
	}

	if (questFields && g.quest !== undefined) {
		const q = data.quest(g.quest);
		goal.quest = g.quest;
		if (q && q.title) goal.title = String(q.title);
		let oi = g.oi;
		if (q && Array.isArray(q.objectives)) {
			// "7.1 = kill Kobold Vermin x10, 7.2 = ...": what `quest Q.O` can name.
			const listed = () => data.questObjectives(g.quest).map((o) => objectiveLabel(g.quest, o)).join(', ');
			if (oi !== undefined && oi > q.objectives.length) {
				warn(
					ln,
					`quest ${g.quest} has ${q.objectives.length} objective(s) in data, not ${oi}${q.objectives.length ? `: ${listed()}` : ''}`,
					q.objectives.length ? `write \`quest ${g.quest}.<n>\` with one of these (\`polestar find ${g.quest}\` lists them)` : `drop the \`.${oi}\`: write \`quest ${g.quest}\``,
				);
			}
			if (oi === undefined) {
				const kind = v === 'kill' ? 'kill' : v === 'collect' ? 'item' : v === 'interact' ? 'object' : null;
				const id = v === 'kill' ? g.npc : v === 'interact' ? g.object : g.item;
				if (id !== undefined) oi = objectiveFor(q, kind, id) || undefined;
				if (oi === undefined && q.objectives.length) {
					warn(ln, `quest ${g.quest} has no objective for this ${v === 'kill' ? 'npc' : v === 'interact' ? 'object' : 'item'}; write \`quest ${g.quest}.<objective>\``, `its objectives: ${listed()}`);
				}
			}
			if (oi !== undefined && g.count === undefined && (v === 'kill' || v === 'collect')) {
				const o = q.objectives[oi - 1];
				if (o && Number(o.count) > 0) goal.count = Number(o.count);
			}
		} else if (!q) {
			warn(ln, `quest ${g.quest} is not in data; objective index and count cannot be filled`);
		}
		if (oi !== undefined) goal.oi = oi;
	}
	if ((v === 'kill' || v === 'collect') && g.count !== undefined) goal.count = g.count;
	// A quest only characters with a profession can take (quests.json `skill`
	// and `skillLevel`, rank 1 when the level is unknown): every goal of it is
	// for them only, as another class's goals are not this character's.
	if (goal.quest !== undefined) {
		const q = data.quest(goal.quest);
		const line = q ? Number(q.skill) : 0;
		if (Number.isInteger(line) && line > 0) {
			const p = data.profession(line);
			goal.profLine = line;
			setIf(goal, 'profName', p && p.name ? String(p.name) : undefined);
			goal.profRank = Number(q.skillLevel) > 0 ? Number(q.skillLevel) : 1;
		}
	}

	// Explicit display text, note, flags.
	if (g.text !== undefined) goal.text = g.text;

	// Coordinates.
	const map = g.coordMap !== undefined ? g.coordMap : zoneMap;
	if (g.explicitCoords) {
		if (g.x < 0 || g.x > 100 || g.y < 0 || g.y > 100) {
			err(ln, `coordinates ${g.x},${g.y} are outside 0-100`);
		} else if (map == null) {
			err(ln, 'coordinates need a zone (`zone` in the header or step, or `map <uiMapID>`)');
		} else {
			goal.map = map;
			goal.x = round2(g.x);
			goal.y = round2(g.y);
			// Hand-typed coordinates are Era-frame unless the guide or goal says `live`.
			// A map with no Era bounds has no Era frame to be in (new Forever zones).
			const frame = ctx.frame || { frame: 'era', explicit: false };
			const hasEra = !!data.eraFrame(map);
			const anyFrames = Object.keys(data.mapFrames.era || {}).length > 0;
			if (frame.frame === 'era' && (hasEra || !anyFrames)) goal.f = 'e';
			else if (frame.frame === 'era' && frame.explicit) {
				warn(ln, `\`era\` coordinates on map ${map}, but map-frames.json has no Era bounds for it; compiling them as live-frame`);
			}
			if (checkKinds && checkKinds.length) checkNear(data, checkKinds, map, goal.x, goal.y, goal.f === 'e' ? 'e' : 'l', ln, warn);
		}
	}
	if (g.frame && !g.explicitCoords) err(ln, `\`${g.frame}\` only applies to explicit coordinates (@x,y)`);
	if (g.explicitCoords && (g.nearest || g.classTrain || (g.profession !== undefined && g.npc === undefined))) {
		err(ln, 'smart targets pick their NPC and position at runtime; drop the coordinates, or name an npc id');
	}
	const picked = pickSpawn(data, candidates, map, prev, { usedMaps: ctx.usedMaps });
	if (picked) {
		const c = picked.cand;
		if (v === 'accept' || v === 'turnin') {
			if (c.kind === 'npc') {
				goal.npc = c.id;
				setIf(goal, 'npcName', nameOf(data, 'npc', c.id));
			} else {
				goal.object = c.id;
				setIf(goal, 'objName', nameOf(data, 'object', c.id));
			}
		} else if (v === 'buy') {
			goal.npc = c.id;
			setIf(goal, 'npcName', nameOf(data, 'npc', c.id));
		}
		if (!g.explicitCoords && picked.x !== undefined) {
			goal.map = picked.map;
			goal.x = picked.x;
			goal.y = picked.y;
			if (picked.f) {
				// An Era point is only usable with that map's Era bounds; without them
				// the client reads it as live-frame, so say so and emit it that way.
				const anyFrames = Object.keys(data.mapFrames.era || {}).length > 0;
				if (data.eraFrame(picked.map) || !anyFrames) goal.f = picked.f;
				else warn(ln, `Era-frame coordinates on map ${picked.map}, but map-frames.json has no Era bounds for it; compiled as live-frame`);
			}
		}
		// Every place the target spawns, so a player who finds nothing where
		// the arrow led can move it on to the others (spawnSpots). Kill,
		// collect and interact goals may be area objectives (`spread`, searched
		// spot by spot); the others go to the nearest place.
		const area = v === 'kill' || v === 'collect' || v === 'interact';
		if (!g.explicitCoords && picked.x !== undefined) {
			const sp = spawnSpots(data, area ? picked.sources || [c] : [c], picked.map, picked.f, picked.x, picked.y);
			if (sp) {
				goal.spots = sp.spots;
				if (sp.spread && area) goal.spread = true;
			}
		} else if (g.explicitCoords && goal.x !== undefined) {
			// Hand-placed: the sources known to give the item (a drop chance, or a
			// gathering node; not loot of unknown odds). A mob or object spawns
			// around a farming point (SPREAD_YARDS); one NPC more than
			// SPAWN_CHECK_YARDS away has moved (the lint's own threshold).
			// Gathering nodes respawn over the zone's whole pool, so a route's
			// point anywhere in it lists every node place.
			const known = area ? candidates.filter((s) => s.chance === undefined || s.chance > 0 || gatherNode(data, s)) : [c];
			const all = known.map((cand) => ({ cand, spawns: data.spawns(cand.kind, cand.id) }));
			const sources = onMap(all, goal.map).map((o) => o.cand);
			const near = !area ? SPAWN_CHECK_YARDS : sources.length && sources.every((s) => gatherNode(data, s)) ? Infinity : SPREAD_YARDS;
			setIf(goal, 'spots', handSpots(data, sources, goal.map, goal.f, goal.x, goal.y, near));
		}
	}
	if (g.r !== undefined) goal.r = g.r;
	if (g.optional) goal.optional = true;
	// Group content (group.js): the author's `group [N]`, else derived.
	setIf(goal, 'group', groupOf(goal, g.group, ctx.sides, data));
	setIf(goal, 'only', onlyOf(g.only));
	setIf(goal, 'note', g.note);

	if ((v === 'kill' || v === 'collect' || v === 'interact' || v === 'use') && goal.x === undefined && !goal.candidates && !g.nearest) {
		warn(ln, `\`${v}\` has no coordinates (no known spawns; add @x,y)`, 'add @x,y where the player finds the target (the map coordinates the game shows), so the arrow can lead there');
	}
	return goal;
}

// Warn when explicit coordinates are far from every known spawn (the capped-out
// ones too). Only spawns recorded in the same map frame (`frame`: "e" | "l")
// are comparable.
function checkNear(data, kinds, map, x, y, frame, ln, warn) {
	let any = false;
	let onMap = false;
	let otherFrame = false;
	for (const k of kinds) {
		for (const s of data.spawns(k.kind, k.id)) {
			any = true;
			if (s.map !== map) continue;
			if ((s.f === 'l' ? 'l' : 'e') !== frame) {
				otherFrame = true;
				continue;
			}
			onMap = true;
			if (!data.mapSize(map)) return; // cannot measure yards on this map
			for (const p of [...s.pts, ...s.more]) if (distance(data, map, p[0], p[1], x, y) <= SPAWN_CHECK_YARDS) return;
		}
	}
	if (!any) return;
	if (!onMap && otherFrame) return; // known spawns on this map are in the other frame: not comparable
	const what = kinds.length === 1 ? `${kinds[0].kind} ${kinds[0].id}` : 'the target';
	const look = kinds.length === 1 ? `\`polestar find ${kinds[0].id} --kind ${kinds[0].kind}\`` : '`polestar find <id>`';
	const hint = `${look} prints a known spawn: check the coordinates against it, or keep them when the target stands elsewhere in Forever`;
	if (!onMap) warn(ln, `explicit coordinates ${x},${y}: ${what} has no known spawn on map ${map}`, hint);
	else warn(ln, `explicit coordinates ${x},${y} are more than ${SPAWN_CHECK_YARDS} yards from every known spawn of ${what}`, hint);
}

module.exports = { resolveGuide, pickSpawn, round2 };
