'use strict';
// Polestar baseline extractor (docs/legacy/SIMULATION-js.md §5): compiles the project's
// guides and turns a race's leveling routes (the default `next` chain and
// every route choice) into normalized event sequences for the simulator.

const fs = require('node:fs');
const path = require('node:path');
const { compileProject } = require('../../dsl/project');
const { CLASSES, RACES } = require('../../game/races');

const MAX_ENUMERATED = 2000;
const ANY_CLASS_MIN = 8; // a class list this long came from a negation (`!Druid`)

function lower(s) {
	return String(s).trim().toLowerCase();
}

// Contract race name -> the race file name guides use ('Undead' -> 'Scourge');
// unknown races (Skyborne) pass through.
function raceFile(race) {
	const r = RACES[lower(race).replace(/[\s_-]/g, '')];
	return r ? r.file : String(race);
}

function onlyHolds(only, ctx) {
	if (!only) return true;
	if (only.factions && !only.factions.includes(ctx.faction)) return false;
	if (only.races && !only.races.includes(ctx.race)) return false;
	if (only.classes) {
		if (ctx.cls) return only.classes.includes(ctx.cls);
		return only.classes.length >= ANY_CLASS_MIN;
	}
	return true;
}

// The NPC or object a compiled accept or turn-in sends the player to: a quest
// with several givers or enders is scored there (sequence.js).
function target(goal) {
	if (goal.npc != null) return { npc: goal.npc };
	if (goal.object != null) return { object: goal.object };
	return null;
}

function guideEvents(g, ctx) {
	const events = [{ t: 'guide', title: g.title, zone: g.zoneName || null, levels: g.minLevel != null ? [g.minLevel, g.maxLevel ?? g.minLevel] : null, id: g.id }];
	for (const step of g.steps || []) {
		if (!onlyHolds(step.only, ctx)) continue;
		const seen = new Set();
		for (const goal of step.goals || []) {
			if (!onlyHolds(goal.only, ctx)) continue;
			let e = null;
			if (goal.t === 'level') e = { t: 'level', level: goal.level, xp: null };
			else if (goal.quest == null) continue;
			else if (goal.t === 'accept' || goal.t === 'turnin') e = { t: goal.t, q: goal.quest, ...target(goal) };
			else {
				const key = `${goal.quest}/${goal.oi ?? ''}`;
				if (seen.has(key)) continue;
				seen.add(key);
				e = { t: 'complete', q: goal.quest, obj: goal.oi ?? null };
			}
			if (goal.optional) e.optional = true;
			events.push(e);
		}
	}
	return events;
}

function shortNamer(ids, faction) {
	const prefix = `forever/${lower(faction)}/`;
	const rel = (id) => (id.startsWith(prefix) ? id.slice(prefix.length) : id);
	const base = (id) => id.slice(id.lastIndexOf('/') + 1);
	const counts = new Map();
	for (const id of ids) counts.set(base(id), (counts.get(base(id)) || 0) + 1);
	return (id) => (counts.get(base(id)) === 1 ? base(id) : rel(id));
}

// Guide id -> its file (relative to dir); resolved guides drop it.
function filesOf(dir, sources, into = new Map()) {
	for (const rel of sources) {
		const m = fs.readFileSync(path.join(dir, rel), 'utf8').match(/^guide\s+(\S+)/m);
		if (m && !into.has(m[1])) into.set(m[1], rel);
	}
	return into;
}

// The race's first leveling guide: the lowest minLevel, then the id. With
// `anyRace`, a guide naming no race (one for the whole faction) counts too.
function firstFor(guides, rFile, { anyRace = false } = {}) {
	return guides
		.filter((g) => (g.races ? g.races.includes(rFile) : anyRace))
		.sort((a, b) => (a.minLevel ?? 99) - (b.minLevel ?? 99) || (a.id < b.id ? -1 : 1))[0];
}

// Routes for a race: { default, variants: [{ label, choices, sequence }], graph, prefix }
// or null when no Polestar guide starts that race. Event objects are shared
// between the sequences; treat them as read-only.
// With `pack` ({ dir, manifest }: another guide pack), the routes are that
// pack's chain instead, compiled with our guides (guidesDir) as context: it
// starts at the pack's first leveling guide for the race and follows `next`
// and route choices, into our guides too. When it starts above level 1, our
// default chain comes first (`prefix`, its guide ids): the race's starting
// guide, then `next` (else the first route choice), up to and including the
// guide whose maxLevel reaches the pack chain's first level.
function loadPolestarRoutes({ guidesDir, dataDir, data = null, faction = null, race, cls = null, quests = null, maxPaths = MAX_ENUMERATED, pack = null } = {}) {
	const rFile = raceFile(race);
	// A one-side race implies its faction; Skyborne (both sides) needs one given.
	const sides = Object.keys((RACES[lower(race).replace(/[\s_-]/g, '')] || {}).sides || {});
	const fac = faction || (sides.length === 1 ? sides[0] : null);
	if (!fac) throw new Error(`polestar: faction needed for race ${race}`);
	const compiled = compileProject({ packDir: guidesDir, dataDir, data });
	if (!quests) quests = compiled.data && compiled.data.quests;
	const fileOf = filesOf(guidesDir, compiled.sources);
	let guides = compiled.guides;
	let packGuides = null;
	if (pack) {
		const p = compileProject({ packDir: pack.dir, manifest: pack.manifest, dataDir, data: compiled.data, contextDir: guidesDir, contextData: compiled.data });
		packGuides = new Set(p.guides.map((g) => g.id));
		filesOf(pack.dir, p.sources, fileOf);
		guides = [...compiled.guides.filter((g) => !packGuides.has(g.id)), ...p.guides];
	}
	const clsFile = cls ? (CLASSES[lower(cls)] || {}).file || String(cls).toUpperCase() : null;
	const ctx = { faction: fac, race: rFile, cls: clsFile };

	const leveling = guides.filter((g) => g.category === 'Leveling' && (!g.faction || g.faction === fac));
	const byId = new Map(leveling.map((g) => [g.id, g]));
	// A pack's chain may start at a guide for the whole faction; ours starts at the race's own guide.
	const start = packGuides ? firstFor(leveling.filter((g) => packGuides.has(g.id)), rFile, { anyRace: true }) : firstFor(leveling, rFile);
	if (!start) return null;
	const lead = [];
	const packFrom = start.minLevel ?? 1;
	if (packGuides && packFrom > 1) {
		const ours = (id) => byId.has(id) && !packGuides.has(id) && !lead.includes(id);
		for (let g = firstFor(leveling.filter((x) => !packGuides.has(x.id)), rFile); g; ) {
			lead.push(g.id);
			if ((g.maxLevel ?? g.minLevel ?? 0) >= packFrom) break;
			const nx = [g.next, ...(g.nextChoices || [])].find((id) => id && ours(id));
			g = nx ? byId.get(nx) : null;
		}
	}
	const name = pack ? pack.manifest.id : 'Polestar';

	const options = (g) => {
		const list = g.nextChoices && g.nextChoices.length ? g.nextChoices : g.next ? [g.next] : [];
		return list.filter((id) => byId.has(id));
	};

	// Graph of everything reachable from the start guide.
	const nodes = [];
	const edges = [];
	const reach = new Set([start.id]);
	for (let i = 0, queue = [start.id]; i < queue.length; i++) {
		const g = byId.get(queue[i]);
		nodes.push({ id: g.id, title: g.title, levels: g.minLevel != null ? [g.minLevel, g.maxLevel ?? g.minLevel] : null, zone: g.zoneName || null });
		for (const to of options(g)) {
			edges.push({ from: g.id, to, default: to === g.next });
			if (!reach.has(to)) {
				reach.add(to);
				queue.push(to);
			}
		}
	}
	const short = shortNamer([...reach], fac);

	const eventCache = new Map();
	const eventsOf = (id) => {
		if (!eventCache.has(id)) eventCache.set(id, guideEvents(byId.get(id), ctx));
		return eventCache.get(id);
	};

	// A sequence plays `lead` (our chain up to the pack's first level) before the path.
	const makeSequence = (route, label) => {
		const ids = [...lead, ...route];
		const events = [];
		for (const id of ids) events.push(...eventsOf(id));
		const qids = [];
		const seen = new Set();
		for (const e of events) {
			if (e.q == null || seen.has(e.q)) continue;
			seen.add(e.q);
			qids.push(e.q);
		}
		return {
			source: 'polestar',
			label,
			faction: fac,
			race,
			class: cls || null,
			guides: ids.map((id) => ({ title: byId.get(id).title, file: fileOf.get(id) || null, id })),
			events,
			missing: quests ? qids.filter((q) => !Object.hasOwn(quests, String(q))) : [],
			flagged: [],
		};
	};

	const choicesOf = (ids) => {
		const out = [];
		for (let i = 0; i + 1 < ids.length; i++) {
			const g = byId.get(ids[i]);
			if (ids[i + 1] !== g.next) out.push({ from: ids[i], to: ids[i + 1] });
		}
		return out;
	};
	const labelOf = (choices) => (choices.length ? choices.map((c) => `${short(c.to)}@${short(c.from)}`).join(' + ') : 'default');

	// Default: follow `next` until it ends or would revisit a guide.
	const defIds = [start.id];
	for (let g = start; g.next && byId.has(g.next) && !defIds.includes(g.next); g = byId.get(g.next)) defIds.push(g.next);

	// Complete paths through the choices (no guide twice), counted up to the cap.
	let count = 0;
	const countPaths = (id, seen) => {
		if (count > maxPaths) return;
		const opts = options(byId.get(id)).filter((o) => !seen.has(o));
		if (!opts.length) {
			count++;
			return;
		}
		for (const o of opts) {
			seen.add(o);
			countPaths(o, seen);
			seen.delete(o);
		}
	};
	countPaths(start.id, new Set([start.id]));

	const paths = [];
	if (count <= maxPaths) {
		const walk = (ids, seen) => {
			const opts = options(byId.get(ids[ids.length - 1])).filter((o) => !seen.has(o));
			if (!opts.length) {
				paths.push(ids.slice());
				return;
			}
			for (const o of opts) {
				ids.push(o);
				seen.add(o);
				walk(ids, seen);
				seen.delete(o);
				ids.pop();
			}
		};
		walk([start.id], new Set([start.id]));
	} else {
		// Too many: the default route, and the default route with one choice
		// changed (then defaults again, or the first unvisited option).
		paths.push(defIds);
		for (let i = 0; i < defIds.length; i++) {
			const prefix = defIds.slice(0, i + 1);
			const g = byId.get(defIds[i]);
			for (const o of options(g)) {
				if (o === defIds[i + 1] || prefix.includes(o)) continue;
				const ids = [...prefix, o];
				const seen = new Set(ids);
				for (let cur = byId.get(o); ; ) {
					const nx = cur.next && byId.has(cur.next) && !seen.has(cur.next) ? cur.next : options(cur).find((x) => !seen.has(x));
					if (!nx) break;
					ids.push(nx);
					seen.add(nx);
					cur = byId.get(nx);
				}
				paths.push(ids);
			}
		}
	}

	const first = byId.get(lead.length ? lead[0] : start.id).minLevel ?? 1;
	const rangeOf = (ids) => {
		const last = byId.get(ids[ids.length - 1]);
		return `${first}-${last.maxLevel ?? last.minLevel ?? '?'}`;
	};
	const variants = paths.map((ids) => {
		const choices = choicesOf(ids);
		const label = labelOf(choices);
		return { label, choices, sequence: makeSequence(ids, `${name} ${rangeOf(ids)} ${label}`) };
	});
	const defKey = [...lead, ...defIds].join('>');
	const defVariant = variants.find((v) => v.sequence.guides.map((x) => x.id).join('>') === defKey);
	return {
		default: defVariant ? defVariant.sequence : makeSequence(defIds, `${name} ${rangeOf(defIds)} default`),
		variants,
		graph: { nodes, edges },
		prefix: lead,
		mode: count <= maxPaths ? 'all' : 'single-change',
		pathCount: count > maxPaths ? null : count,
	};
}

// A guide's events without its `optional` goals: what the guide requires. A
// quest whose accept is optional is left out whole (its objectives and
// turn-in too); other optional goals are left out one by one. Guide hours
// are scored on these unless `sim compare --with-optional` (issue #30).
function requiredEvents(events) {
	const optQuest = new Set(events.filter((e) => e.optional && e.t === 'accept').map((e) => Number(e.q)));
	return events.filter((e) => !e.optional && !(e.q != null && optQuest.has(Number(e.q))));
}

module.exports = { loadPolestarRoutes, requiredEvents };
