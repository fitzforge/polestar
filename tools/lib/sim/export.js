'use strict';
// `sim export`: zone-by-zone skeleton guides (docs/GUIDE_FORMAT.md) from a
// `sim run` result, for authors to refine, plus visits.json beside them
// (machine-readable: per zone visit the level range, quests in order with
// giver/ender names, hubs and map positions, hearth binds, flight paths
// learned, hearthstone uses and grind stops). One .guide per zone visit of
// the route, chained with `next`; steps are the accepts, objectives and
// turn-ins the simulator actually did, in its order, one step per spot, plus
// `getfp`/`sethome`/`hearth`/`level` steps where the simulator learned a
// flight path, bound or used its hearthstone, or ground. Coordinates are
// left to the compiler (it fills them from the data).

const fs = require('node:fs');
const path = require('node:path');
const sim = require('./index');
const { K_ACCEPT, K_TASK, K_TURNIN, K_DUNGEON } = require('./run');
const { LEVEL_XP } = require('../game/xp');
const { ISLE_MAPS, ISLANDS, cluster } = require('./world');
const { loadAreas } = require('../exploration/areas');
const { loadData } = require('../route/model');
const { completionistGuides } = require('./completionist-guides');

function slug(s) {
	return String(s).toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '');
}

const r1 = (v) => Math.round(v * 10) / 10;

// Named places per zone map: the client's map areas (subzones and towns,
// WorldMapOverlay/AreaTable via tools/lib/exploration/areas.js; centres in
// live-frame map percent) in world yards: { [map]: [{ name, wx, wy }] }.
async function loadPlaces(o) {
	const { areas } = await loadAreas({ sourcesDir: o.sourcesDir, offline: true, islands: ISLE_MAPS, log: () => {} });
	const frames = JSON.parse(fs.readFileSync(path.join(o.dataDir, 'map-frames.json'), 'utf8'));
	const out = {};
	for (const [map, list] of Object.entries(areas)) {
		const b = (frames.forever && frames.forever[map]) || (frames.era && frames.era[map]);
		if (!b) continue;
		out[map] = list.map((a) => ({ name: a.areas[0].name, wx: b.top + ((b.bottom - b.top) * a.y) / 100, wy: b.left + ((b.right - b.left) * a.x) / 100 }));
	}
	return out;
}

// Name of the place a point is at: the nearest named area (subzone or town)
// of the point's own zone map; without areas there, the nearest flight
// master or inn on its landmass within 1000 yd ("near X").
function placeNamer(world, places = {}) {
	const W = world.points;
	const named = [];
	for (const n of world.nodes) if (n.kind === 'fp') named.push({ name: n.name, pt: n.pt });
	for (const n of world.inns) named.push({ name: n.name, pt: n.pt });
	const cache = new Map();
	return (pt) => {
		if (cache.has(pt)) return cache.get(pt);
		const P = W[pt];
		let best = null;
		let bd = Infinity;
		for (const a of places[P[4]] || []) {
			const d = Math.hypot(a.wx - P[2], a.wy - P[3]);
			if (d < bd) {
				bd = d;
				best = a.name;
			}
		}
		if (best == null) {
			bd = 1000;
			for (const n of named) {
				const Q = W[n.pt];
				if (Q[1] !== P[1]) continue;
				const d = Math.hypot(Q[2] - P[2], Q[3] - P[3]);
				if (d < bd) {
					bd = d;
					best = n.name;
				}
			}
			if (best != null && bd > 200) best = `near ${best}`;
		}
		cache.set(pt, best);
		return best;
	};
}

// Mob camps for grind stops. The simulator grinds where it stands (time
// only, a rate per level), which can be a capital city; a guide needs a
// place with mobs of the right level. A camp: at least GRIND_MIN spawns of
// one normal quest mob within GRIND_R of each other. Quest mobs (a quest's
// kill target, or a dropper of a quest item with at most 20 droppers; no
// faction, rank 0) keep out town guards and event spawns, which npcs.json
// does not mark. -> [{ name, level, size, region, wx, wy, map, x, y }]
const GRIND_R = 120;
const GRIND_MIN = 6;
function loadCamps(o) {
	const read = (f) => JSON.parse(fs.readFileSync(path.join(o.dataDir, f), 'utf8'));
	const npcs = read('npcs.json');
	const items = read('items.json');
	const frames = read('map-frames.json');
	const zones = read('zones.json');
	const mobs = new Set();
	for (const q of Object.values(read('quests.json'))) {
		for (const ob of (q && q.objectives) || []) {
			if (ob.type === 'kill') mobs.add(String(ob.id));
			else if (ob.type === 'item') {
				const droppers = Object.keys(((items[ob.id] || {}).drops || {}).npc || {});
				if (droppers.length <= 20) for (const id of droppers) mobs.add(id);
			}
		}
	}
	const era = frames.era || {};
	const live = frames.forever || {};
	const frameOf = (map, f) => (f === 'l' && live[map]) || era[map] || live[map] || null;
	const camps = [];
	for (const raw of Object.values(npcs)) {
		const lo = Number.parseInt(raw.level, 10);
		if (!mobs.has(String(raw.id)) || raw.faction || raw.rank || !Number.isFinite(lo)) continue;
		const hi = Number.parseInt(raw.levelMax, 10);
		const level = Math.round((lo + (Number.isFinite(hi) ? hi : lo)) / 2);
		const pts = [];
		for (const [map, sp] of Object.entries(raw.spawns || {})) {
			const b = frameOf(map, sp && sp.f);
			if (!b || !zones[map] || zones[map].type !== 3 || !Array.isArray(sp.pts)) continue;
			for (const p of sp.pts) {
				if (!Array.isArray(p) || p.length < 2) continue;
				pts.push({ wx: b.top + ((b.bottom - b.top) * p[1]) / 100, wy: b.left + ((b.right - b.left) * p[0]) / 100, region: b.c * 10 + (ISLANDS[map] || 0), map: Number(map), x: p[0], y: p[1] });
			}
		}
		if (pts.length < GRIND_MIN) continue;
		for (const c of cluster(pts, GRIND_R)) {
			if (c.size < GRIND_MIN) continue;
			const s = pts[c.seed];
			camps.push({ name: String(raw.name), level, size: c.size, region: s.region, wx: c.cx, wy: c.cy, map: s.map, x: r1(s.x), y: r1(s.y) });
		}
	}
	return camps;
}

// Where a grind from level `from` goes: the camp on the point's landmass
// with mobs from one level below the character to two above, nearer and
// bigger preferred (min(size, 15) / (1 + distance / 400)), named by the
// nearest map area. -> { mob, level, zone, map, x, y, area } or null.
function grindSpotter(world, camps = [], places = {}) {
	const W = world.points;
	return (pt, from) => {
		const P = W[pt];
		const lo = Math.floor(from) - 1;
		const hi = Math.floor(from) + 2;
		let best = null;
		let bs = 0;
		for (const c of camps) {
			if (c.region !== P[1] || c.level < lo || c.level > hi || !world.zones[c.map]) continue;
			const sc = Math.min(c.size, 15) / (1 + Math.hypot(c.wx - P[2], c.wy - P[3]) / 400);
			if (sc > bs) {
				bs = sc;
				best = c;
			}
		}
		if (!best) return null;
		let area = null;
		let ad = Infinity;
		for (const a of places[best.map] || []) {
			const d = Math.hypot(a.wx - best.wx, a.wy - best.wy);
			if (d < ad) {
				ad = d;
				area = a.name;
			}
		}
		return { mob: best.name, level: best.level, zone: world.zones[best.map], map: best.map, x: best.x, y: best.y, area };
	};
}

// "on <mob> (level N) at <area>, <zone> x,y" for a grind with a camp, else
// "near <where the character stands>".
function grindText(g) {
	if (g.spot) return `on ${g.spot.mob} (level ${g.spot.level}) at ${g.spot.area ? `${g.spot.area}, ` : ''}${g.spot.zone} ${g.spot.x},${g.spot.y}`;
	return g.near ? `near ${g.near}` : '';
}

// Everything the evaluator did along a route, in order:
//   { type: 'step', kind, q (quest id) | dungeon, title, pt, level, time, pkg }
//   { type: 'grind' | 'fp' | 'bind' | 'hearth', pt, level, time, pkg, ... }
function executedSteps(ev, run, route) {
	const out = [];
	let pkg = -1;
	const level = () => ev.level + (ev.level < 60 ? ev.xp / LEVEL_XP[ev.level] : 0);
	ev.hook = (k, q, pt) => {
		if (k === K_DUNGEON) out.push({ type: 'step', kind: k, dungeon: run.dungeons[q].name, pt, level: level(), time: ev.time, pkg });
		else out.push({ type: 'step', kind: k, q: run.quests[q].id, title: run.quests[q].title, pt, level: level(), time: ev.time, pkg });
	};
	ev.onEvent = (type, info) => out.push({ type, ...info, pt: info.pt != null ? info.pt : ev.pos, level: level(), time: ev.time, pkg });
	try {
		ev.reset();
		for (const p of route) {
			if (ev.finished) break;
			pkg = p;
			if (!ev.runPackage(p)) break;
		}
		pkg = -1;
		ev.finish();
	} finally {
		ev.hook = null;
		ev.onEvent = null;
	}
	return out;
}

// Zone visits from executed steps (events join the visit they happen in;
// the grind to 60 after the last package is a visit of its own). A visit's
// packages are the ones whose steps it ran; a grind for the next package
// (level 10 before leaving the continent) names that package as `before`.
// Each grind gets the camp to grind at (`spot`, grindSpotter), the final
// grind's visit that camp's zone.
function visitsOf(world, run, entries, guideIdBase, places, camps) {
	const W = world.points;
	const zoneOf = (pt) => {
		const m = W[run.ptList[pt]][4];
		return { map: m, zone: world.zones[m] || `map ${m}` };
	};
	const place = placeNamer(world, places);
	const spotFor = grindSpotter(world, camps, places);
	for (const e of entries) if (e.type === 'grind') e.spot = spotFor(run.ptList[e.pt], e.from);
	const qById = new Map(world.quests.map((q) => [q.id, q]));
	const hubName = (h, pt) => place(h >= 0 ? world.hubs[h].pt : pt);
	const visits = [];
	let cur = null;
	for (const e of entries) {
		const z = zoneOf(e.pt);
		const finalGrind = e.type === 'grind' && e.pkg < 0;
		if (finalGrind) {
			cur = { zone: '(grind to 60)', map: z.map, where: e.spot ? e.spot.zone : z.zone, entries: [e] };
			visits.push(cur);
			continue;
		}
		// Events before the first step of a zone stay with the previous visit.
		if (!cur || (e.type === 'step' && cur.zone !== z.zone)) {
			cur = { zone: z.zone, map: z.map, entries: [] };
			visits.push(cur);
		}
		cur.entries.push(e);
	}
	return visits.map((v, i) => {
		const lv = v.entries.map((e) => e.level);
		const out = {
			n: i + 1,
			zone: v.zone,
			map: v.map,
			guide: `${guideIdBase}/${String(i + 1).padStart(2, '0')}-${slug(v.zone)}`,
			levelIn: r1(Math.min(...lv)),
			levelOut: r1(Math.max(...lv)),
			arrive: Math.round(v.entries[0].time),
			leave: Math.round(v.entries[v.entries.length - 1].time),
			packages: [...new Set(v.entries.filter((e) => e.type === 'step' && e.pkg >= 0).map((e) => run.packages[e.pkg].key))],
			quests: [],
			dungeons: [],
			binds: [],
			flightPaths: [],
			hearths: [],
			grinds: [],
		};
		if (v.where) out.where = v.where;
		const qs = new Map();
		for (const e of v.entries) {
			if (e.type === 'step' && e.kind === K_DUNGEON) out.dungeons.push({ name: e.dungeon, level: r1(e.level) });
			else if (e.type === 'step') {
				let q = qs.get(e.q);
				if (!q) {
					const wq = qById.get(e.q);
					q = {
						id: e.q, title: e.title, level: wq ? wq.level : null,
						giver: { name: wq && wq.gName, hub: wq ? hubName(wq.hubGiver, wq.giver) : null, pos: wq && wq.gPos },
						ender: { name: wq && wq.eName, hub: wq ? hubName(wq.hubEnder, wq.ender) : null, pos: wq && wq.ePos },
					};
					qs.set(e.q, q);
					out.quests.push(q);
				}
				if (e.kind === K_ACCEPT) q.acceptedAt = r1(e.level);
				else if (e.kind === K_TASK) q.objectivesAt = r1(e.level);
				else if (e.kind === K_TURNIN) q.turnedInAt = r1(e.level);
			} else if (e.type === 'bind') out.binds.push({ inn: world.inns[e.inn].name, level: r1(e.level) });
			else if (e.type === 'fp') out.flightPaths.push({ name: world.nodes[e.node].name, level: r1(e.level) });
			else if (e.type === 'hearth') out.hearths.push({ to: world.inns[e.inn].name, level: r1(e.level) });
			else if (e.type === 'grind') {
				const g = { zone: zoneOf(e.pt).zone, near: place(run.ptList[e.pt]), from: r1(e.from), to: r1(e.to), minutes: Math.round(e.seconds / 60) };
				if (e.spot) g.spot = e.spot;
				if (e.pkg >= 0 && !v.entries.some((x) => x.type === 'step' && x.pkg === e.pkg)) g.before = run.packages[e.pkg].key;
				out.grinds.push(g);
			}
		}
		out.entries = v.entries;
		return out;
	});
}

// .guide texts for the visits.
function guidesFor(meta, visits) {
	return visits.map((v, i) => {
		const lo = Math.max(1, Math.floor(v.levelIn));
		const hi = Math.max(lo, Math.min(60, Math.ceil(v.levelOut)));
		const zone = v.zone === '(grind to 60)' ? v.where : v.zone;
		const lines = [
			`guide ${v.guide}`,
			// The range has its own header (`levels`); the menu shows it beside the title.
			`title ${v.zone === '(grind to 60)' ? `Grinding in ${zone}` : zone}`,
			`faction ${meta.faction}`,
			`race ${meta.race}`,
			`levels ${lo}-${hi}`,
			`zone ${zone}`,
		];
		if (i + 1 < visits.length) lines.push(`next ${visits[i + 1].guide}`);
		lines.push(
			`# Skeleton from \`polestar sim export\` (${meta.label}). Era + known Forever quests only.`,
			'# Quests in the order the simulator did them; review every step in game before publishing.',
			'',
		);
		let cur = null;
		const open = () => {
			if (cur) lines.push('');
		};
		for (const e of v.entries) {
			if (e.type === 'step') {
				if (e.kind === K_DUNGEON) {
					open();
					lines.push(`step Run ${e.dungeon} (level ${e.level.toFixed(1)})`, `  note Run ${e.dungeon}`);
					cur = { pt: -1 };
					continue;
				}
				if (!cur || cur.pt !== e.pt) {
					open();
					const what = e.kind === K_TASK ? `Objectives: ${e.title}` : e.kind === K_ACCEPT ? 'Pick up quests' : 'Turn in';
					lines.push(`step ${what} (level ${e.level.toFixed(1)})`);
					cur = { pt: e.pt };
				}
				const verb = e.kind === K_ACCEPT ? 'accept' : e.kind === K_TASK ? 'complete' : 'turnin';
				lines.push(`  ${verb} ${e.q}`);
				continue;
			}
			open();
			cur = { pt: -1 };
			if (e.type === 'fp') lines.push(`step Flight path (level ${e.level.toFixed(1)})`, `  getfp "${e.name}"`);
			else if (e.type === 'bind') lines.push(`step Hearthstone (level ${e.level.toFixed(1)})`, `  sethome "${e.inn}"`);
			else if (e.type === 'hearth') lines.push(`step Hearth (level ${e.level.toFixed(1)})`, `  hearth "${e.inn}"`);
			else if (e.type === 'grind') {
				const to = Math.min(60, Math.floor(e.to + 1e-6));
				const where = grindText(e);
				if (to <= Math.floor(e.from)) lines.push(`step Grind (${Math.round(e.seconds / 60)} min)`, `  note Grind ${Math.round(e.seconds / 60)} minutes${where ? ` ${where}` : ''} (level ${e.from.toFixed(1)} to ${e.to.toFixed(1)})`);
				else lines.push(`step Grind to ${to} (${Math.round(e.seconds / 60)} min)`, `  level ${to}${where ? ` -- grind ${where}` : ''}`);
			}
		}
		return { id: v.guide, file: `${v.guide}.guide`, text: `${lines.join('\n')}\n` };
	});
}

// Names on events (fp, inn, grind place) for the guide texts.
function nameEvents(world, run, visits, places) {
	const place = placeNamer(world, places);
	for (const v of visits) {
		for (const e of v.entries) {
			if (e.type === 'fp') e.name = world.nodes[e.node].name;
			else if (e.type === 'bind' || e.type === 'hearth') e.inn = world.inns[e.inn].name;
			else if (e.type === 'grind') e.near = place(run.ptList[e.pt]);
		}
	}
}

// Export one route: guides + visits.json under `out`. meta: { faction, race,
// label, family, seconds }; places: loadPlaces(); camps: loadCamps().
// A completionist route (meta.family) writes Completionist guides instead of
// skeletons (completionist-guides.js; `completionist`: { data, coverage,
// limit }). Returns { guides, visits, file }.
function exportRoute({ world, ev, run, route, meta, out, base, places, camps, completionist = null }) {
	const entries = executedSteps(ev, run, route);
	const visits = visitsOf(world, run, entries, base, places, camps);
	nameEvents(world, run, visits, places);
	const guides = completionist
		? completionistGuides({ world, run, data: completionist.data, entries, meta, place: placeNamer(world, places), coverage: completionist.coverage, base, limit: completionist.limit })
		: guidesFor(meta, visits);
	for (const g of guides) {
		const file = path.join(out, g.file);
		fs.mkdirSync(path.dirname(file), { recursive: true });
		fs.writeFileSync(file, g.text);
	}
	const doc = {
		schema: 1,
		note: 'Era + known Forever quests (Forever 30-60 content not in the data yet). Simulator output for guide authors; positions are zone map percent. A grind\'s `near` is where the simulator stood (its grind is time only); `spot` is the mob camp of the right level to grind at.',
		...meta,
		hours: meta.seconds != null ? r1(meta.seconds / 3600) : undefined,
		visits: visits.map(({ entries, ...v }) => ({ ...v, hours: r1((v.leave - v.arrive) / 3600) })),
	};
	const file = path.join(out, 'visits.json');
	fs.mkdirSync(out, { recursive: true });
	fs.writeFileSync(file, `${JSON.stringify(doc, null, 1)}\n`);
	return { guides, visits: doc.visits, file };
}

async function exportGuides(o) {
	const res = JSON.parse(fs.readFileSync(o.result, 'utf8'));
	const { world } = o.world ? { world: o.world } : await sim.loadWorld({ ...o, faction: res.faction, variant: sim.variantOf(res.family) });
	sim.assertFresh(res, world, path.basename(o.result));
	const places = await loadPlaces(o);
	const camps = loadCamps(o);
	const { ev, run } = sim.makeRun(world, { race: res.race, cls: res.class === 'any' ? null : res.class, params: res.params, family: res.family });
	const route = sim.routeFromKeys(run, res.best.route);
	const meta = { faction: res.faction, race: res.race, family: res.family, worldHash: world.dataHash, label: `${res.faction} ${res.race}, ${res.family}, best route ${(res.best.seconds / 3600).toFixed(1)} h under the model`, seconds: res.best.seconds };
	if (res.family === 'completionist') {
		const data = { ...loadData(o.dataDir), professions: readJson(path.join(o.dataDir, 'professions.json')) };
		const coverage = require('./completionist').coverage({ world, run, ev, route, data });
		// The Completionist guides are their own pack (packs/completionist,
		// pack id `completionist`), so their ids start with its prefix.
		const base = `completionist/${res.faction.toLowerCase()}/${slug(res.race)}`;
		meta.label = `the simulator's completionist route for ${res.race} (${res.best.questsDone} of ${res.best.eligible} eligible quests, ${(res.best.seconds / 3600).toFixed(1)} h, world ${world.dataHash.slice(0, 12)})`;
		return exportRoute({ world, ev, run, route, meta, out: o.out, base, places, camps, completionist: { data, coverage, limit: o.limit || Infinity } });
	}
	const base = `sim/${res.faction.toLowerCase()}/${slug(res.race)}${res.family === 'solo' ? '' : `-${res.family}`}`;
	return exportRoute({ world, ev, run, route, meta, out: o.out, base, places, camps });
}

function readJson(file) {
	return fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : {};
}

async function command(args, o) {
	if (!args.result) throw new Error('--result <file> is required');
	const out = path.resolve(args.out || path.join(sim.DEFAULTS.simDir, 'export'));
	const r = await exportGuides({ ...sim.DEFAULTS, ...o, result: path.resolve(args.result), out, limit: args.limit ? Number(args.limit) : undefined });
	console.log(`wrote ${r.guides.length} skeleton guides and ${path.relative(process.cwd(), r.file)} under ${path.relative(process.cwd(), out) || '.'}`);
	for (const g of r.guides) console.log(`  ${g.file}`);
	return 0;
}

module.exports = { exportGuides, exportRoute, loadPlaces, loadCamps, grindSpotter, placeNamer, guidesFor, visitsOf, executedSteps, command, slug };
