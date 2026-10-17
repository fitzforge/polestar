'use strict';
// The planner's playback engine (docs/ARCHITECTURE.md, "Route planner"):
// a route of compiled guides played goal by goal for one character with the
// simulator's priors (tools/lib/sim/params.js means), the XP rules of
// tools/lib/game/xp.js and the flights and boats of travel.json.
//
//   routeOf({ guides, start, character, choices })  -> [guideId...]
//   buildTimeline({ guides, data, geo, params, travel, start, character, choices, startLevel, startXp, questXp, routes, nav })
//
// `guides` is anything with get(id)/has(id) (a Map of compiled guides).
// `questXp`: the QuestXP table rows (tools/lib/game/xp.js); undefined reads
// the cached table under data/sources when present (as the simulator does),
// null estimates rewards from the built-in anchors.
//
// Decided here, beyond the spec's table:
// - a smart target goes to the candidate of the character's side nearest the
//   character; a goal on a map without a frame has no place (warning);
// - `fly "X"` ends at the taxi node of the character's faction whose `short`
//   or `name` is X (case-insensitive); the flight starts at the nearest flight
//   master that reaches it and is drawn through the nodes of the cheapest path;
// - a boat, zeppelin or tram is taken whenever walk + wait + ride + walk beats
//   the walk (always when the next place is on another continent);
// - `sethome` binds at the travel.json inn named by its location, else at the
//   goal's place; `hearth` without a bind warns and is skipped;
// - kills move the character between up to `count` spawn points of the target
//   (nearest first inside the chosen spot, else around the place); expected
//   kills may be fractional: rounded up for the samples, exact for time and XP;
// - item objectives follow the bag; event objectives complete when the
//   character reaches their point (60 yd) or by `complete` (escortSec);
// - walks (docs/ARCHITECTURE.md, "Navigation grid"): every walk leg of
//   moveTo (to a goal's place, a boat, a flight
//   master, a spawn pool away from the character) asks `routes(a, b,
//   profile)`, a synchronous route provider -> { ok, reason, pts (wx, wy, z
//   per point), cls (per segment, tools/lib/nav/grid/format.js CLS), yards,
//   seconds, byClass, falls } or null (not known yet), with the profile of
//   tools/lib/nav/move.js profileFor({ cls, level, params }) at the
//   character's level. A routed leg takes the route's seconds and its track
//   follows the route's points (a mode per segment); a leg without a route
//   keeps the straight-line estimate (distance x detour / speed) and, when
//   a provider was given, marks its goal and step `estimate` with
//   `routeReason` ('pending' while the route is being computed). Without a
//   provider (`routes` null) every walk is the straight-line model,
//   unmarked. The hops between spawn points inside a kill, collect or
//   interact area (picked nearest first, as before) ask the provider too: a
//   routed hop takes its route's seconds (fight mode on the track), one
//   without keeps the spacing model's walk (mean nearest-neighbour spacing x
//   spacing / run speed) and is marked the same way. Totals: legs / routed
//   (walk legs), hops / hopsRouted, routeSeconds and estimateSeconds (both
//   kinds). The choice between walking and a boat or a flight master
//   compares straight-line times. `nav` ({ build }) is recorded as the
//   timeline's `nav`;
// - flights keep their time (yards / FLIGHT_SPEED + FLIGHT_STOP per leg);
//   with `flightPaths` (path id -> [[wx, wy], ...], the TaxiPathNode points
//   of travel.json's taxi legs) their track follows the points the gryphon
//   flies, the leg's time shared by length; without, node to node.

const fs = require('node:fs');
const path = require('node:path');
const { ROOT, DATA, SOURCES } = require('../paths');
const { LEVEL_XP, MAX_LEVEL, gain, parseQuestXp, baseQuestXp, questXpShare, mobXp } = require('../game/xp');
const { loadParamsFile, effective, means } = require('../sim/params');
const { applicable, maskExcludes } = require('../dsl/conditions');
const { CLASS_BY_FILE, classLabel } = require('../game/races');
const { HOME } = require('../playtest');
const { profileFor } = require('../nav/move');

// Track modes; swim .. indoor are the routed segments' classes (walk, steep
// and jump segments are walk or ride).
const MODES = { stand: 0, walk: 1, fight: 2, fly: 3, boat: 4, teleport: 5, ride: 6, swim: 7, fall: 8, climb: 9, lift: 10, indoor: 11 };
// Route segment classes (tools/lib/nav/grid/format.js CLS: walk, steep, swim,
// jump, fall, indoor, climb, lift) -> their byClass key (jumps count as walk)
// and their track mode (null: walk or ride).
const SEG_KEY = ['walk', 'steep', 'swim', 'walk', 'fall', 'indoor', 'climb', 'lift'];
const SEG_MODE = [null, null, MODES.swim, null, MODES.fall, MODES.indoor, MODES.climb, MODES.lift];
const CATS = ['travel', 'combat', 'interact', 'wait'];
const ELITE_RANKS = new Set([1, 2, 3]);
const FACTION_BIT = { Alliance: 1, Horde: 2 };
const SIDE_TAG = { Alliance: 'A', Horde: 'H' };
const MAX_GUIDES = 120;
const AREA_YARDS = 150; // farming radius around a place without a spot or `r`
const POOL_MAX = 60; // spawn points considered per farmed target
const EVENT_YARDS = 60; // reaching an event objective's point completes it
const NO_SPAWN_SPACING = 30; // yards between mobs when the data has no spawns
// Flights: the addon's own timing (addon/Polestar/Maps/FlightTimer.lua), seconds = yards / speed + stop per hop.
const FLIGHT_SPEED = 30;
const FLIGHT_STOP = 2;
// Drop chance (%) assumed without a recorded rate, as the simulator does (tools/lib/sim/world.js).
const UNKNOWN_DROP = 30;
const UNKNOWN_QUEST_DROP = 60;
// Kill objectives that are a conversation's credit (the simulator's rule).
const TALK_RE = /^\s*(speak|listen|talk|hear|show|wait|watch)\b/i;
// Escort quests (the simulator's ESCORT_RE in tools/lib/sim/world.js, local
// there): their event objectives take escortSec; other events are visits.
const ESCORT_RE = /\bescort|\bprotect\b|\bdefend\b|\bkeep .* safe|\bguide .* safely|\blead .* to safety|\bescape\b/i;
const isEscort = (quest) => !!quest && ESCORT_RE.test([quest.objectiveText, ...(quest.objectives || []).map((o) => o && o.text)].filter(Boolean).join(' '));
// A quest level of 0 or less is unknown: minLevel, else the guide's qlvl, else the character's.
const questLevel = (quest, qlvl, level) => (quest && quest.level > 0 ? quest.level : quest && quest.minLevel > 0 ? quest.minLevel : qlvl > 0 ? qlvl : level);
const TALK = new Set(['accept', 'turnin', 'talk', 'getfp', 'sethome', 'train', 'vendor', 'buy', 'learn']);
const UNMODELLED = new Set(['note', 'skill', 'craft', 'rep', 'achieve']);

const r1 = (v) => Math.round(v * 10) / 10;
const r2 = (v) => Math.round(v * 100) / 100;
const lower = (s) => String(s == null ? '' : s).trim().toLowerCase();

// --- parameters and tables ---------------------------------------------------

// Simulator means (calibrated when data/sim/params.json has them) with the
// class factor; cls as a class file ('SHAMAN') or label ('Shaman').
function loadParams({ simDir = path.join(ROOT, 'data', 'sim'), cls = null } = {}) {
	const name = cls ? (CLASS_BY_FILE[String(cls).toUpperCase()] ? classLabel(String(cls).toUpperCase()) : String(cls)) : null;
	return means(effective(loadParamsFile(simDir), name));
}

let cachedQuestXp;
function cachedQuestXpRows() {
	if (cachedQuestXp === undefined) {
		cachedQuestXp = null;
		const dir = path.join(SOURCES, 'wago');
		// The newest cached Era build with the table (the simulator's loader caches it there).
		const builds = fs.existsSync(dir) ? fs.readdirSync(dir).filter((b) => fs.existsSync(path.join(dir, b, 'QuestXP.csv'))).sort() : [];
		const pick = builds.includes('1.15.9.70003') ? '1.15.9.70003' : builds[builds.length - 1];
		if (pick) {
			try {
				cachedQuestXp = parseQuestXp(fs.readFileSync(path.join(dir, pick, 'QuestXP.csv'), 'utf8'));
			} catch {
				cachedQuestXp = null;
			}
		}
	}
	return cachedQuestXp;
}

// Quest followers per data object, for the QuestXP difficulty tier of a chain's end.
const followerCache = new WeakMap();
function hasFollowers(data, id) {
	let set = followerCache.get(data);
	if (!set) {
		set = new Set();
		for (const q of Object.values(data.quests || {})) for (const p of (q && q.pre) || []) set.add(Number(p));
		followerCache.set(data, set);
	}
	return set.has(Number(id));
}

// --- conditions ----------------------------------------------------------------

// Does a condition layer ({ faction | factions, races, classes }, any absent)
// admit the character ({ race, cls, faction })?
function appliesTo(character, layer) {
	if (!layer) return true;
	const factions = layer.factions || (layer.faction ? [layer.faction] : null);
	if (factions && factions.length && !factions.includes(character.faction)) return false;
	if (layer.races && layer.races.length && !layer.races.includes(character.race)) return false;
	if (layer.classes && layer.classes.length && !layer.classes.includes(character.cls)) return false;
	return true;
}

function guideApplies(character, g) {
	return appliesTo(character, { faction: g.faction, races: g.races, classes: g.classes });
}

// The quest's race and class masks against the character.
function questAdmits(character, quest) {
	if (!quest) return true;
	const set = applicable([{ factions: [character.faction], races: [character.race], classes: [character.cls] }]);
	return maskExcludes(set, quest) === null;
}

// --- labels ------------------------------------------------------------------

let defaultZones;
function zoneNameOf(names, map) {
	if (names && typeof names.zoneName === 'function') return names.zoneName(map);
	if (typeof names === 'function') return names(map);
	if (names && names.zones) {
		const z = names.zones[String(map)];
		return z && z.name ? String(z.name) : null;
	}
	if (defaultZones === undefined) {
		const file = path.join(DATA, 'zones.json');
		try {
			defaultZones = fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null;
		} catch {
			defaultZones = null;
		}
	}
	const z = defaultZones && defaultZones[String(map)];
	return z && z.name ? String(z.name) : null;
}

const times = (n) => (n > 1 ? ` x${n}` : '');

// One line naming what a compiled goal asks: "Accept Frostmane Hold",
// "Kill Frostmane Headhunter x5", "Go to Dun Morogh 24.5, 50.8". `names`
// (optional): a Geo, a Data, or map -> zone name; else data/forever's zones.
function goalLabel(goal, names = null) {
	if (!goal) return '';
	if (goal.text) return String(goal.text);
	const where = () => {
		if (goal.x == null || goal.map == null) return '';
		const z = zoneNameOf(names, goal.map) || `map ${goal.map}`;
		return `${z} ${goal.x.toFixed(1)}, ${goal.y.toFixed(1)}`;
	};
	const quest = goal.title || (goal.quest != null ? `quest ${goal.quest}` : '');
	const npc = goal.npcName || (goal.npc != null ? `npc ${goal.npc}` : '');
	switch (goal.t) {
		case 'accept': return `Accept ${quest}`;
		case 'turnin': return `Turn in ${quest}`;
		case 'complete': return `Complete ${quest}`;
		case 'kill': return `Kill ${goal.target || npc || 'target'}${times(goal.count)}`;
		case 'collect': return `Collect ${goal.itemName || `item ${goal.item}`}${times(goal.count)}`;
		case 'interact': return `Use ${goal.objName || `object ${goal.object}`}${times(goal.count)}`;
		case 'use': return `Use ${goal.itemName || `item ${goal.item}`}${times(goal.count)}`;
		case 'talk': return `Talk to ${npc}`;
		case 'sethome': return `Set hearth${goal.location ? ` at ${goal.location}` : npc ? ` with ${npc}` : ''}`;
		case 'getfp': return `Get the flight path${goal.location ? ` at ${goal.location}` : npc ? ` from ${npc}` : ''}`;
		case 'fly': return `Fly to ${goal.location}`;
		case 'hearth': return `Hearth${goal.location ? ` to ${goal.location}` : ''}`;
		case 'train': return goal.class ? 'Train class skills' : goal.skill ? `Train ${goal.skill}` : `Train${npc ? ` with ${npc}` : ''}`;
		case 'vendor': return `Sell and repair${npc ? ` at ${npc}` : ''}`;
		case 'buy': return `Buy ${goal.itemName || `item ${goal.item}`}${times(goal.count)}`;
		case 'learn': return `Learn ${goal.spellName || `spell ${goal.spell}`}`;
		case 'craft': return `Craft ${goal.spellName || `spell ${goal.spell}`}${times(goal.count)}`;
		case 'level': return `Reach level ${goal.level}`;
		case 'skill': return `${goal.skill} ${goal.level}`;
		case 'rep': return `${goal.factionName} ${goal.standing}`;
		case 'achieve': return goal.achievementName || `Achievement ${goal.achievement}`;
		case 'explore': return `Explore ${where()}`.trim();
		case 'goto': return `Go to ${where()}`.trim();
		case 'note': return goal.note ? String(goal.note) : 'Note';
		default: return String(goal.t);
	}
}

// What a compiled goal names, for the page's icons and links: { item,
// itemName, npc, npcName (a kill's target when the goal has no npcName),
// object, objName, spell, skill (profession name), cls (true for `train
// class`), location, quest }, only the keys it has.
const REF_KEYS = ['item', 'itemName', 'npc', 'npcName', 'object', 'objName', 'spell', 'skill', 'location', 'quest'];
function goalRef(goal) {
	const ref = {};
	for (const k of REF_KEYS) if (goal[k] != null && goal[k] !== '') ref[k] = goal[k];
	if (ref.npcName == null && goal.target) ref.npcName = String(goal.target);
	if (goal.class) ref.cls = true;
	return ref;
}

// --- route ---------------------------------------------------------------------

// start, then each `next`: choices[id] when it is one of the options, else the
// first option the character can follow; stops at a guide the character
// cannot follow, after MAX_GUIDES guides or on a cycle.
function routeOf({ guides, start, character, choices = {} }) {
	const out = [];
	const seen = new Set();
	let id = start;
	while (id && guides.has(id) && !seen.has(id) && out.length < MAX_GUIDES) {
		const g = guides.get(id);
		if (out.length && !guideApplies(character, g)) break;
		out.push(id);
		seen.add(id);
		const options = g.nextChoices || (g.next ? [g.next] : []);
		const ok = (o) => guides.has(o) && guideApplies(character, guides.get(o));
		const chosen = choices && choices[id];
		id = chosen && options.includes(chosen) && ok(chosen) ? chosen : options.find(ok) || null;
	}
	return out;
}

// --- travel network ----------------------------------------------------------

const netCache = new WeakMap();
function network(travel, faction) {
	let byFaction = netCache.get(travel);
	if (!byFaction) netCache.set(travel, (byFaction = {}));
	if (byFaction[faction]) return byFaction[faction];
	const bit = FACTION_BIT[faction] || 3;
	const nodes = ((travel.taxi && travel.taxi.nodes) || []).filter((n) => (n.faction & bit) !== 0);
	const index = new Map(nodes.map((n, i) => [n.id, i]));
	const into = nodes.map(() => []);
	for (const l of (travel.taxi && travel.taxi.legs) || []) {
		const a = index.get(l.from);
		const b = index.get(l.to);
		if (a != null && b != null) into[b].push([a, (Number(l.yards) || 0) / FLIGHT_SPEED + FLIGHT_STOP, l.path != null ? Number(l.path) : null]);
	}
	const transports = (travel.transports || []).filter((t) => (t.faction & bit) !== 0 && t.a && t.b);
	const rides = [];
	for (const t of transports) {
		// Walked to and from the deck where a ship lying off its pier is boarded (travel build's `board`).
		const da = t.a.board ? { ...t.a, ...t.a.board } : t.a;
		const db = t.b.board ? { ...t.b, ...t.b.board } : t.b;
		rides.push({ kind: t.kind, from: da, to: db, ride: Number(t.ab) || 0, wait: Number(t.waitA) || 0 });
		rides.push({ kind: t.kind, from: db, to: da, ride: Number(t.ba) || 0, wait: Number(t.waitB) || 0 });
	}
	const inns = travel.inns || [];
	return (byFaction[faction] = { nodes, into, rides, inns, toDest: new Map() });
}

// Cheapest flight time from every node to node `dest` (Dijkstra on reversed
// legs) with the next hop and its taxi path id: { dist: [], next: [], path: [] }.
function flightsTo(net, dest) {
	if (net.toDest.has(dest)) return net.toDest.get(dest);
	const N = net.nodes.length;
	const dist = new Array(N).fill(Infinity);
	const next = new Array(N).fill(-1);
	const via = new Array(N).fill(null);
	const done = new Array(N).fill(false);
	dist[dest] = 0;
	for (;;) {
		let u = -1;
		for (let i = 0; i < N; i++) if (!done[i] && dist[i] < Infinity && (u < 0 || dist[i] < dist[u])) u = i;
		if (u < 0) break;
		done[u] = true;
		for (const [a, cost, pathId] of net.into[u]) {
			if (dist[u] + cost < dist[a]) {
				dist[a] = dist[u] + cost;
				next[a] = u;
				via[a] = pathId;
			}
		}
	}
	const out = { dist, next, path: via };
	net.toDest.set(dest, out);
	return out;
}

// --- the engine ----------------------------------------------------------------

function buildTimeline({ guides, data, geo, params, travel = null, start, character, choices = {}, startLevel = null, startXp = 0, questXp, optional = false, routes = null, nav = null, flightPaths = null }) {
	const p = params;
	const ch = character;
	const net = network(travel || data.travel || {}, ch.faction);
	const qxpRows = questXp === undefined ? cachedQuestXpRows() : questXp;
	const route = routeOf({ guides, start, character: ch, choices });
	const first = route.length ? guides.get(route[0]) : null;

	const me = { level: Math.max(1, Math.min(MAX_LEVEL, startLevel != null ? startLevel : first && first.minLevel ? first.minLevel : 1)), xp: Math.max(0, startXp || 0) };
	if (me.level < MAX_LEVEL && me.xp >= LEVEL_XP[me.level]) me.xp = LEVEL_XP[me.level] - 1;
	if (me.level >= MAX_LEVEL) me.xp = 0;
	const out = {
		schema: 1,
		character: { race: ch.race, cls: ch.cls, faction: ch.faction, startLevel: me.level, startXp: me.xp },
		guides: [],
		steps: [],
		track: { t: [], c: [], x: [], y: [], m: [] },
		events: [],
		totals: { seconds: 0, split: { travel: 0, combat: 0, interact: 0, wait: 0 }, level: me.level, xp: me.xp, quests: 0, legs: 0, routed: 0, hops: 0, hopsRouted: 0, routeSeconds: 0, estimateSeconds: 0 },
		warnings: [],
		nav: nav ? { build: nav.build || null } : null,
	};
	const track = out.track;
	let t = 0;
	let pos = null; // { c, wx, wy }
	let bind = null;
	let hearthAt = null;
	const fps = [];
	const log = new Map(); // quest id -> { id, title, qlvl, objectives: [{ type, id, text, cur, max, at }], ready }
	const done = new Set();
	const bag = new Map(); // item id -> { id, name, count }
	let step = null; // the step being played
	let goalOut = null; // the goal being played
	let guideId = null;
	let stepIndex = -1;

	const xpMax = () => (me.level >= MAX_LEVEL ? 0 : LEVEL_XP[me.level]);
	const mounted = () => me.level >= p.mountLevel;
	const speed = () => p.runSpeed * (mounted() ? p.mountMul : 1);
	const walkMode = () => (mounted() ? MODES.ride : MODES.walk);
	const detour = (c) => (c === 0 ? p.detour0 : c === 1 ? p.detour1 : 1.3);
	const dist = (a, b) => Math.hypot(a.wx - b.wx, a.wy - b.wy);
	const walkTime = (a, b) => (dist(a, b) * detour(a.c)) / speed();
	const warn = (line, message) => out.warnings.push({ guide: guideId, line: line == null ? null : line, message });
	const event = (type, fields) => out.events.push({ t: r2(t), s: stepIndex, type, ...fields });

	const spend = (cat, sec) => {
		if (!(sec > 0)) return;
		t += sec;
		if (goalOut) goalOut.split[cat] += sec;
		if (step) step.split[cat] += sec;
		out.totals.split[cat] += sec;
	};
	const sample = (m) => {
		track.t.push(r2(t));
		track.c.push(pos.c);
		track.x.push(r1(pos.wx));
		track.y.push(r1(pos.wy));
		track.m.push(m);
	};
	// A sample where the character stands now, when time passed since the last one.
	const hold = (m = MODES.stand) => {
		if (pos && (!track.t.length || track.t[track.t.length - 1] < r2(t))) sample(m);
	};

	// XP with its dings (each costs levelOverhead of waiting).
	const earn = (amount, type, fields) => {
		const before = me.level;
		const ups = amount > 0 ? gain(me, amount) : 0;
		if (step) step.xp += amount;
		if (goalOut) goalOut.xp += amount;
		event(type, { ...fields, gain: r2(amount), level: me.level, xp: r2(me.xp), xpMax: xpMax() });
		for (let l = before + 1; l <= before + ups; l++) {
			event('ding', { level: l, xp: r2(me.xp), xpMax: xpMax() });
			if (step) step.dings.push(l);
			spend('wait', p.levelOverhead);
		}
	};

	// --- places ---
	const worldOf = (map, x, y, f) => {
		const w = geo.toWorld(map, x, y, f === 'e' ? 'e' : 'l');
		return w ? { c: w.c, wx: w.wx, wy: w.wy, map: Number(map), x, y, f: f === 'e' ? 'e' : 'l' } : null;
	};
	// Distance for picking: other continents far behind any same-continent choice.
	const pickDist = (w) => (!pos ? 0 : w.c === pos.c ? dist(pos, w) : 1e9 + dist({ wx: 0, wy: 0 }, w));
	const nearest = (list) => {
		let best = null;
		let bd = Infinity;
		for (const w of list) {
			const d = pickDist(w);
			if (d < bd) {
				bd = d;
				best = w;
			}
		}
		return best;
	};
	const sideOk = (tag) => !tag || tag === 'AH' || tag === SIDE_TAG[ch.faction];

	// Spawn points of an npc/object as world points (deduplicated across maps), cached.
	const spawnCache = new Map();
	const spawnsOf = (kind, id) => {
		const key = `${kind}:${id}`;
		if (spawnCache.has(key)) return spawnCache.get(key);
		const pts = [];
		const seen = new Set();
		for (const s of data.spawns(kind, id)) {
			for (const q of [...s.pts, ...s.more]) {
				const w = geo.toWorld(s.map, q[0], q[1], s.f === 'e' ? 'e' : 'l');
				if (!w) continue;
				const k = `${w.c}:${Math.round(w.wx / 3)}:${Math.round(w.wy / 3)}`;
				if (seen.has(k)) continue;
				seen.add(k);
				pts.push({ c: w.c, wx: w.wx, wy: w.wy });
			}
		}
		spawnCache.set(key, pts);
		return pts;
	};

	// The place of a goal: { at, r, spots } (at null when it has none); warns
	// only for a goal the character plays (`loud`).
	const placeOf = (goal, loud) => {
		const say = (msg) => loud && warn(goal._line, msg);
		let at = null;
		let r = goal.r != null ? goal.r : null;
		let spots = [];
		if (Array.isArray(goal.candidates) && goal.candidates.length && goal.x == null) {
			const ok = goal.candidates.filter((c) => sideOk(c.faction) && (!c.classes || !c.classes.length || c.classes.includes(ch.cls)));
			const ws = [];
			for (const c of ok) {
				const w = c.map != null && c.x != null ? worldOf(c.map, c.x, c.y, c.f) : null;
				if (w) ws.push(Object.assign(w, { cand: c }));
			}
			at = nearest(ws);
			if (!at && ok.length) say(`no candidate of ${goalLabel(goal, geo)} has a frame on the map`);
			if (!ok.length) say(`no candidate of ${goalLabel(goal, geo)} for a ${ch.faction} ${ch.cls}`);
		} else if (goal.map != null && goal.x != null) {
			at = worldOf(goal.map, goal.x, goal.y, goal.f);
			if (!at) say(`map ${goal.map} has no frame in map-frames.json; the goal has no place`);
		}
		if (at && Array.isArray(goal.spots) && goal.spots.length) {
			spots = goal.spots.map((s) => {
				const w = worldOf(goal.map, s.x, s.y, goal.f);
				return w ? { c: w.c, wx: r1(w.wx), wy: r1(w.wy), r: s.r, n: s.n, alt: !!s.alt, map: goal.map, x: s.x, y: s.y } : null;
			}).filter(Boolean);
			const pick = nearest(spots.filter((s) => !s.alt)) || nearest(spots);
			if (pick) {
				at = { c: pick.c, wx: pick.wx, wy: pick.wy, map: pick.map, x: pick.x, y: pick.y, f: at.f };
				if (r == null) r = pick.r;
			}
		}
		return { at, r, spots: spots.map(({ c, wx, wy, r: sr, n, alt }) => ({ c, wx, wy, r: sr, n, alt })) };
	};

	const named = (list, name) => {
		const n = lower(name);
		if (!n) return null;
		return list.find((x) => lower(x.short) === n || lower(x.name) === n || lower(x.location) === n || (x.names || []).some((y) => lower(y) === n)) || null;
	};

	// --- moving ---
	// The quickest way from a to b: { sec, ride } (ride null: walk), or null
	// (another continent no transport reaches).
	const way = (a, b) => {
		let best = a.c === b.c ? { sec: walkTime(a, b), ride: null } : null;
		for (const ride of net.rides) {
			if (ride.from.c !== a.c || ride.to.c !== b.c) continue;
			const sec = walkTime(a, ride.from) + ride.wait * p.transportWait + ride.ride + walkTime(ride.to, b);
			if (!best || sec < best.sec) best = { sec, ride };
		}
		return best;
	};

	// Movement profiles per level (tools/lib/nav/move.js), for the route provider.
	const profiles = new Map();
	const profileNow = () => {
		if (!profiles.has(me.level)) profiles.set(me.level, profileFor({ cls: ch.cls, level: me.level, params: p }));
		return profiles.get(me.level);
	};
	// The goal's routed legs, summed: { yards, byClass, falls }.
	const addRoute = (r) => {
		if (!goalOut) return;
		const g = goalOut.route || (goalOut.route = { yards: 0, byClass: {}, falls: [] });
		g.yards = r1(g.yards + (r.yards || 0));
		for (const [k, v] of Object.entries(r.byClass || {})) if (v > 0) g.byClass[k] = r2((g.byClass[k] || 0) + v);
		for (const f of r.falls || []) g.falls.push({ h: r1(f.h), damage: r2(f.damage) });
	};
	// The route from pos to `to` when the provider has a usable one: the route,
	// or { r: null, reason } ('pending' when it is not computed yet).
	const routeTo = (to) => {
		const r = routes ? routes({ c: pos.c, wx: pos.wx, wy: pos.wy }, to, profileNow()) : null;
		if (r && r.ok && r.pts && r.pts.length >= 6 && r.seconds >= 0) return { r, reason: null };
		return { r: null, reason: r ? r.reason || 'no route' : 'pending' };
	};
	// A walk the grid could not route: its goal and step rest on an estimate.
	const markStraight = (reason) => {
		if (!routes) return;
		if (step) step.estimate = true;
		if (goalOut) {
			goalOut.estimate = true;
			goalOut.routeReason = reason;
		}
	};
	// Walk route r from pos to `to` in `scale` x its seconds (a fractional last
	// kill walks a share of its hop): each class's seconds (byClass) shared by
	// length among its segments, scaled to the route's total (remounts and
	// the like belong to no class); a sample per point, mode(segment class).
	const followRoute = (r, to, mode, scale = 1) => {
		const pts = r.pts;
		const n = pts.length / 3 - 1;
		const len = new Float64Array(n);
		const keyLen = {};
		const keyCount = {};
		for (let i = 0; i < n; i++) {
			len[i] = Math.hypot(pts[3 * i + 3] - pts[3 * i], pts[3 * i + 4] - pts[3 * i + 1]);
			const key = SEG_KEY[r.cls[i]] || 'walk';
			keyLen[key] = (keyLen[key] || 0) + len[i];
			keyCount[key] = (keyCount[key] || 0) + 1;
		}
		const by = r.byClass || {};
		const sec = new Float64Array(n);
		let sum = 0;
		for (let i = 0; i < n; i++) {
			const key = SEG_KEY[r.cls[i]] || 'walk';
			const s = by[key] || 0;
			sec[i] = keyLen[key] > 0 ? (s * len[i]) / keyLen[key] : s / keyCount[key];
			sum += sec[i];
		}
		const yards = len.reduce((a, b) => a + b, 0);
		const total = r.seconds * scale;
		for (let i = 0; i < n; i++) sec[i] = sum > 0 ? (sec[i] * total) / sum : yards > 0 ? (total * len[i]) / yards : total / n;
		// The snapped start and end may sit a few yards off: joined without time.
		pos = { c: to.c, wx: pts[0], wy: pts[1] };
		sample(mode(0));
		for (let i = 0; i < n; i++) {
			spend('travel', sec[i]);
			pos = { c: to.c, wx: pts[3 * i + 3], wy: pts[3 * i + 4] };
			sample(mode(r.cls[i]));
		}
		if (dist(pos, to) >= 0.5) {
			pos = to;
			sample(mode(0));
		}
		pos = to;
		addRoute(r);
	};
	// Walk from pos to `dest` (same continent): along the route when the
	// provider has one, else the straight-line estimate.
	const walkLeg = (dest) => {
		const to = { c: dest.c, wx: dest.wx, wy: dest.wy };
		if (dist(pos, to) < 0.5) {
			pos = to;
			sample(walkMode());
			return;
		}
		const totals = out.totals;
		totals.legs++;
		const { r, reason } = routeTo(to);
		if (!r) {
			const sec = walkTime(pos, to);
			spend('travel', sec);
			totals.estimateSeconds += sec;
			pos = to;
			sample(walkMode());
			markStraight(reason);
			return;
		}
		followRoute(r, to, (cls) => (SEG_MODE[cls] == null ? walkMode() : SEG_MODE[cls]));
		totals.routed++;
		totals.routeSeconds += r.seconds;
	};
	// One hop between spawn points inside a kill or collect area, from pos to
	// `to`: along its route (fight mode: the search between spawns), else the
	// spacing model's `straightSec`; a share `frac` of it for a fractional kill.
	const walkHop = (to, straightSec, frac) => {
		const totals = out.totals;
		if (dist(pos, to) < 0.5) {
			spend('travel', straightSec * frac);
			pos = to;
			return;
		}
		totals.hops++;
		const { r, reason } = routes ? routeTo(to) : { r: null, reason: null };
		if (!r) {
			spend('travel', straightSec * frac);
			if (routes) totals.estimateSeconds += straightSec * frac;
			pos = to;
			markStraight(reason);
			return;
		}
		followRoute(r, to, () => MODES.fight, frac);
		totals.hopsRouted++;
		totals.routeSeconds += r.seconds * frac;
	};
	// One flight leg from pos to node `to` in `sec` (its flight plus the stop
	// at its end), along the TaxiPathNode points of taxi path `pathId` when
	// flightPaths has them (the flight's seconds shared by length), else straight.
	const flyLeg = (to, sec, pathId) => {
		const pts = flightPaths && pathId != null ? (typeof flightPaths === 'function' ? flightPaths(pathId) : flightPaths.get(pathId)) : null;
		const end = { c: to.c, wx: to.wx, wy: to.wy };
		if (pts && pts.length >= 2) {
			const flight = Math.max(0, sec - FLIGHT_STOP);
			const poly = [[pos.wx, pos.wy], ...pts, [end.wx, end.wy]];
			let yards = 0;
			for (let i = 1; i < poly.length; i++) yards += Math.hypot(poly[i][0] - poly[i - 1][0], poly[i][1] - poly[i - 1][1]);
			for (let i = 1; i < poly.length; i++) {
				const d = Math.hypot(poly[i][0] - poly[i - 1][0], poly[i][1] - poly[i - 1][1]);
				spend('travel', yards > 0 ? (flight * d) / yards : flight / (poly.length - 1));
				pos = { c: end.c, wx: poly[i][0], wy: poly[i][1] };
				sample(MODES.fly);
			}
			spend('travel', sec - flight);
			hold();
			return;
		}
		spend('travel', sec);
		pos = end;
		sample(MODES.fly);
	};

	// Arrive at a world point: walking, or a boat/zeppelin/tram when that is
	// quicker (the only way to another continent).
	const moveTo = (dest) => {
		if (!dest) return;
		if (!pos) {
			pos = { c: dest.c, wx: dest.wx, wy: dest.wy };
			sample(MODES.teleport);
			return;
		}
		if (pos.c === dest.c && dist(pos, dest) < 0.5) return;
		const best = way(pos, dest);
		hold();
		if (!best) {
			warn(goalOut ? goalOut.line : null, `no boat or zeppelin of travel.json reaches continent ${dest.c} from ${pos.c}; teleported`);
			pos = { c: dest.c, wx: dest.wx, wy: dest.wy };
			sample(MODES.teleport);
			return;
		}
		if (best.ride) {
			const r = best.ride;
			walkLeg(r.from);
			spend('travel', r.wait * p.transportWait);
			hold();
			spend('travel', r.ride);
			pos = { c: r.to.c, wx: r.to.wx, wy: r.to.wy };
			sample(MODES.boat);
			event('boat', { kind: r.kind, from: r.from.name, to: r.to.name });
		}
		if (pos.c === dest.c && dist(pos, dest) >= 0.5) {
			walkLeg(dest);
		}
		arrived();
	};

	// Event objectives complete where they happen.
	const arrived = () => {
		for (const q of log.values()) {
			q.objectives.forEach((o, i) => {
				if (o.type === 'event' && !q.escort && o.at && o.cur < o.max && o.at.c === pos.c && dist(o.at, pos) <= EVENT_YARDS) setProgress(q, i, o.max);
			});
		}
	};

	// --- quest log and bag ---
	const setProgress = (q, i, cur) => {
		const o = q.objectives[i];
		const v = Math.max(0, Math.min(o.max, Math.floor(cur + 1e-9)));
		if (v === o.cur) return;
		o.cur = v;
		event('progress', { quest: q.id, oi: i + 1, cur: v, max: o.max });
		const ready = q.objectives.every((x) => x.cur >= x.max);
		if (ready && !q.ready) event('ready', { quest: q.id });
		q.ready = ready;
	};
	const setItem = (id, name, count) => {
		const cur = bag.get(id) || { id, name: name || `item ${id}`, count: 0 };
		const n = Math.max(0, Math.floor(count + 1e-9));
		if (n === cur.count && bag.has(id)) return;
		cur.count = n;
		if (name && cur.name.startsWith('item ')) cur.name = name;
		if (n > 0) bag.set(id, cur);
		else bag.delete(id);
		event('item', { id, name: cur.name, count: n });
		for (const q of log.values()) q.objectives.forEach((o, i) => o.type === 'item' && o.id === id && setProgress(q, i, n));
	};
	const have = (id) => (bag.has(id) ? bag.get(id).count : 0);

	const questFull = (quest, entry, goal) => {
		// -> { full, estimate }: the full reward before the level share
		if (quest && quest.repeatable && !(typeof quest.xp === 'number' && quest.xp > 0)) return { full: 0, estimate: false };
		if (quest && typeof quest.xp === 'number' && quest.xp > 0) return { full: quest.xp * p.questXpScale, estimate: false };
		if (!quest && goal.rewards && goal.rewards.xp > 0) return { full: goal.rewards.xp, estimate: false };
		const qlvl = questLevel(quest, entry && entry.qlvl, me.level);
		let base;
		if (qxpRows) {
			const tier = quest && quest.breadcrumbFor ? 3 : quest && (quest.pre || []).length && !hasFollowers(data, quest.id) ? 6 : 5;
			const row = qxpRows[Math.max(1, Math.min(qxpRows.length - 1, qlvl))] || qxpRows[60];
			base = row[tier] || 0;
		} else base = baseQuestXp(qlvl);
		return { full: base * p.questEstScale * p.questXpScale, estimate: true };
	};

	// --- work at a target's spawns ---
	// Spawn pool around `center` (inside `radius`, else the nearest ones), the
	// mean nearest-neighbour spacing, and the farming walk through it.
	const poolOf = (kind, id, center, radius) => {
		const all = id != null ? spawnsOf(kind, id) : [];
		if (!all.length || !center) return { pts: [], spacing: 0 };
		const same = all.filter((q) => q.c === center.c);
		if (!same.length) return { pts: [], spacing: 0 };
		const R = radius != null ? Math.max(radius, 20) : AREA_YARDS;
		const byD = same.map((q) => ({ q, d: dist(q, center) })).sort((a, b) => a.d - b.d);
		let pts = byD.filter((x) => x.d <= R).map((x) => x.q);
		if (!pts.length) pts = byD.slice(0, 10).map((x) => x.q);
		if (pts.length > POOL_MAX) pts = pts.slice(0, POOL_MAX);
		let spacing = 0;
		if (pts.length > 1) {
			let sum = 0;
			for (const a of pts) {
				let m = Infinity;
				for (const b of pts) if (a !== b) m = Math.min(m, dist(a, b));
				sum += m;
			}
			spacing = sum / pts.length;
		}
		return { pts, spacing };
	};

	// `n` actions (fractional) on spawn points of `kind`/`id` around the
	// character's place; act(k, frac) does the k-th one (1-based).
	const farm = (kind, id, name, n, radius, act, fallbackSpacing) => {
		const center = pos ? { c: pos.c, wx: pos.wx, wy: pos.wy } : null;
		const { pts, spacing } = poolOf(kind, id, center, radius);
		const sp = pts.length ? spacing : fallbackSpacing;
		const walkPer = (sp * p.spacing) / p.runSpeed;
		const left = pts.slice();
		if (pts.length) {
			// A pool away from the character (the place was elsewhere or missing): walk there first.
			const near = nearest(pts);
			if (dist(near, pos) > Math.max(radius || 0, AREA_YARDS) * 2) moveTo(near);
		}
		const used = [];
		const total = Math.ceil(n - 1e-9);
		for (let k = 1; k <= total; k++) {
			const frac = Math.min(1, n - (k - 1));
			hold(MODES.fight);
			if (pts.length) {
				if (!left.length) left.push(...pts);
				let bi = 0;
				for (let i = 1; i < left.length; i++) if (dist(left[i], pos) < dist(left[bi], pos)) bi = i;
				const q = left.splice(bi, 1)[0];
				if (used.length < POOL_MAX && !used.includes(q)) used.push(q);
				// The hop to the next spawn: routed on the grid, else the spacing model's walk.
				walkHop({ c: q.c, wx: q.wx, wy: q.wy }, walkPer, frac);
			} else spend('travel', walkPer * frac);
			if (pos) {
				const last = track.t.length - 1;
				if (last < 0 || track.x[last] !== r1(pos.wx) || track.y[last] !== r1(pos.wy)) sample(MODES.fight);
				else hold(MODES.fight);
			}
			act(k, frac);
		}
		hold(MODES.fight);
		if (pos) arrived();
		const shown = used.length ? used : pts;
		return shown.length ? { kind, id, name, c: shown[0].c, pts: shown.map((q) => [r1(q.wx), r1(q.wy)]) } : null;
	};

	const npcInfo = (id) => {
		const raw = id != null ? data.npc(id) : null;
		if (!raw) return { name: id != null ? `npc ${id}` : null, level: me.level, elite: false };
		const lo = typeof raw.level === 'number' ? raw.level : Number.parseInt(raw.level, 10);
		const hi = typeof raw.levelMax === 'number' ? raw.levelMax : lo;
		const level = Number.isFinite(lo) ? Math.round((lo + (Number.isFinite(hi) ? hi : lo)) / 2) : me.level;
		return { name: String(raw.name || `npc ${id}`), level, elite: ELITE_RANKS.has(Number(raw.rank)) };
	};
	const killSec = (L, M, elite) => {
		const base = p.killSec1 + ((p.killSec60 - p.killSec1) * (L - 1)) / 59;
		const d = M - L;
		const f = d >= 0 ? 1 + p.killUp * d : Math.max(0.5, 1 + p.killDown * d);
		return base * f * p.classFactor * (elite ? p.eliteTime : 1);
	};

	// Kill `need` of an npc (plus extraKill incidental kills); onTargetKills(tk,
	// k, n) hears the target kills so far; returns { kills, spawns }. A kill
	// objective of quest `questId` on an NPC of the character's own faction
	// that gives or ends the quest, or one worded as a conversation ("Listen
	// as ..."), is one talk at the NPC (the simulator's rule).
	const killWork = (npcId, need, { name: nameHint = null, radius = null, onTargetKills = null, level: levelHint = null, questId = null, text = '' } = {}) => {
		const info = npcInfo(npcId);
		const name = nameHint || info.name || 'target';
		const raw = npcId != null ? data.npc(npcId) : null;
		const q = questId != null ? data.quest(questId) : null;
		const handles = (ends) => !!(ends && (ends.npc || []).map(Number).includes(Number(npcId)));
		const ownNpc = !!(raw && raw.faction === SIDE_TAG[ch.faction] && q && (handles(q.start) || handles(q.end)));
		if (ownNpc || (questId != null && TALK_RE.test(text))) {
			if (raw) {
				const pts = spawnsOf('npc', npcId);
				if (pts.length && (!pos || pos.c !== nearest(pts).c || dist(nearest(pts), pos) > Math.max(radius || 0, AREA_YARDS))) moveTo(nearest(pts));
			}
			spend('interact', p.talkSec);
			if (npcId != null) for (const q of log.values()) q.objectives.forEach((o, i) => o.type === 'kill' && o.id === npcId && setProgress(q, i, o.cur + need));
			if (onTargetKills) onTargetKills(need, 1, 1);
			return { kills: 0, spawns: null };
		}
		const M = levelHint != null ? levelHint : info.level;
		const n = need * (1 + p.extraKill);
		// Kill objectives of every quest in the log on this npc.
		const watch = [];
		if (npcId != null) {
			for (const q of log.values()) q.objectives.forEach((o, i) => o.type === 'kill' && o.id === npcId && o.cur < o.max && watch.push({ q, i, base: o.cur }));
		}
		const spawns = farm('npc', npcId, name, n, radius, (k, frac) => {
			spend('combat', killSec(me.level, M, info.elite) * frac);
			const amount = mobXp(me.level, M, info.elite) * (1 + p.restedShare) * frac;
			const tk = Math.floor(Math.min(k, n) / (1 + p.extraKill) + 1e-6);
			for (const w of watch) setProgress(w.q, w.i, w.base + tk);
			if (onTargetKills) onTargetKills(tk, k, n);
			earn(amount, 'kill', { npc: npcId != null ? npcId : null, name, n: r2(frac) });
		}, NO_SPAWN_SPACING);
		for (const w of watch) setProgress(w.q, w.i, w.base + need);
		return { kills: n, spawns };
	};

	// The source of an item nearest the character, weighed by drop chance as
	// the simulator weighs it: a drop without a recorded rate counts
	// UNKNOWN_DROP % (quest items UNKNOWN_QUEST_DROP) and only when no source
	// has a recorded one; a friendly NPC "dropping" at 50 % or more hands it
	// over; elites cost more.
	const sourceOf = (itemId) => {
		const it = data.item(itemId);
		if (!it || !it.drops) return null;
		const recorded = ['npc', 'object'].some((k) => Object.values(it.drops[k] || {}).some((c) => c != null && Number(c) > 0));
		let best = null;
		for (const kind of ['npc', 'object']) {
			for (const [sid, raw] of Object.entries(it.drops[kind] || {})) {
				if (raw == null && recorded) continue;
				const id = Number(sid);
				const chance = Math.min(100, raw == null ? (it.questItem ? UNKNOWN_QUEST_DROP : UNKNOWN_DROP) : Number(raw) || 0);
				if (!(chance > 0)) continue;
				const pts = spawnsOf(kind, id);
				if (!pts.length) continue;
				const npc = kind === 'npc' ? data.npc(id) : null;
				const handed = !!(npc && npc.faction && sideOk(npc.faction) && chance >= 50);
				const near = nearest(pts);
				const cost = (handed ? 1 : 100 / chance) + pickDist(near) / 300 + (npc && ELITE_RANKS.has(Number(npc.rank)) ? 4 : 0);
				if (!best || cost < best.cost) best = { kind, id, chance, cost, near, handed };
			}
		}
		return best;
	};

	// Collect `need` more of an item from its drops.
	const collectWork = (itemId, itemName, need, radius, hasPlace) => {
		const src = sourceOf(itemId);
		const startCount = have(itemId);
		if (!src) {
			// No known dropper (handed over, gathered elsewhere): the items come with no time.
			setItem(itemId, itemName, startCount + need);
			return { kills: 0, spawns: null, estimate: true };
		}
		if (!hasPlace) moveTo(src.near);
		if (src.handed) {
			if (pos && dist(src.near, pos) > AREA_YARDS) moveTo(src.near);
			spend('interact', p.talkSec);
			setItem(itemId, itemName, startCount + need);
			return { kills: 0, spawns: null, estimate: false };
		}
		const rate = (src.chance / 100) * p.dropMul;
		if (src.kind === 'npc') {
			const kills = need / rate;
			const res = killWork(src.id, kills, { radius, onTargetKills: (tk, k, n) => setItem(itemId, itemName, startCount + Math.min(need, (Math.min(k, n) / n) * need)) });
			setItem(itemId, itemName, startCount + need);
			return { kills: res.kills, spawns: res.spawns, estimate: false };
		}
		const uses = need / rate;
		const obj = data.object(src.id);
		const spawns = farm('object', src.id, obj && obj.name ? String(obj.name) : `object ${src.id}`, uses, radius, (k, frac) => {
			spend('interact', p.interactSec * frac);
			setItem(itemId, itemName, startCount + Math.min(need, (Math.min(k, uses) / uses) * need));
		}, NO_SPAWN_SPACING);
		setItem(itemId, itemName, startCount + need);
		return { kills: 0, spawns, estimate: false };
	};

	const objectiveIndex = (entry, goal, type, id) => {
		if (!entry) return -1;
		if (goal.oi != null && entry.objectives[goal.oi - 1]) return goal.oi - 1;
		return id == null ? -1 : entry.objectives.findIndex((o) => o.type === type && o.id === id);
	};

	// --- guides, steps, goals ---
	for (let gi = 0; gi < route.length; gi++) {
		const id = route[gi];
		const g = guides.get(id);
		guideId = id;
		const gOut = {
			id, title: g.title || id, file: (g._ast && g._ast.file) || null,
			s0: out.steps.length, s1: out.steps.length - 1, start: r2(t), end: r2(t),
			levelStart: me.level, levelEnd: me.level, next: route[gi + 1] || null, choices: g.nextChoices || null,
		};
		out.guides.push(gOut);
		const astSteps = (g._ast && g._ast.steps) || [];
		if (gi === 0) {
			// Start: the race's home for a guide from level 1, else its first place.
			const home = HOME[ch.race];
			if (home && (g.minLevel || 1) <= 1) {
				const w = geo.toWorld(home[0], home[1], home[2], ch.race === 'Skyborne' ? 'l' : 'e');
				if (w) pos = { c: w.c, wx: w.wx, wy: w.wy };
			}
			if (!pos) {
				for (const s of g.steps) {
					for (const goal of s.goals) {
						const w = goal.map != null && goal.x != null ? geo.toWorld(goal.map, goal.x, goal.y, goal.f === 'e' ? 'e' : 'l') : null;
						if (w && !pos) pos = { c: w.c, wx: w.wx, wy: w.wy };
					}
					if (pos) break;
				}
			}
			if (pos) sample(MODES.stand);
		}
		g.steps.forEach((s, si) => {
			stepIndex = out.steps.length;
			const stepApplies = appliesTo(ch, s.only);
			step = {
				i: stepIndex, gi, si, line: s._line != null ? s._line : null, title: s.title || null, label: s.title || (s.goals.length ? goalLabel(s.goals[0], geo) : ''),
				applies: stepApplies, start: r2(t), end: r2(t), split: { travel: 0, combat: 0, interact: 0, wait: 0 }, estimate: false,
				levelStart: me.level, xpStart: r2(me.xp), levelEnd: me.level, xpEnd: r2(me.xp), dings: [], xp: 0,
				k0: Math.max(0, track.t.length - 1), k1: Math.max(0, track.t.length - 1), goals: [],
				state: {
					level: me.level, xp: r2(me.xp), xpMax: xpMax(),
					log: [...log.values()].map((q) => ({ id: q.id, title: q.title, objectives: q.objectives.map((o) => ({ text: o.text, cur: o.cur, max: o.max })), ready: q.ready })),
					items: [...bag.values()].map((x) => ({ ...x })),
					bind: bind ? { ...bind } : null,
					hearthReady: hearthAt == null || hearthAt <= t, hearthAt: hearthAt != null && hearthAt > t ? r2(hearthAt) : null,
					fps: fps.slice(), mounted: mounted(),
				},
			};
			out.steps.push(step);
			const astGoals = (astSteps[si] && astSteps[si].goals) || [];
			s.goals.forEach((goal, gIdx) => {
				const quest = goal.quest != null ? data.quest(goal.quest) : null;
				const applies = stepApplies && appliesTo(ch, goal.only) && questAdmits(ch, quest);
				const place = placeOf(goal, applies);
				goalOut = {
					gi: gIdx, line: goal._line != null ? goal._line : null, verb: goal.t, label: goalLabel(goal, geo), applies, skip: null,
					start: r2(t), end: r2(t), split: { travel: 0, combat: 0, interact: 0, wait: 0 }, xp: 0, kills: 0,
					at: place.at ? { c: place.at.c, wx: r1(place.at.wx), wy: r1(place.at.wy), map: place.at.map, x: place.at.x, y: place.at.y, f: place.at.f } : null,
					r: place.r, spots: place.spots, spawns: null,
					explicit: !!(astGoals[gIdx] && astGoals[gIdx].explicitCoords),
					quest: goal.quest != null ? { id: goal.quest, title: goal.title || (quest && quest.title ? String(quest.title) : `quest ${goal.quest}`) } : null,
					ref: goalRef(goal),
				};
				step.goals.push(goalOut);
				playGoal(goal, quest, place, applies);
				goalOut.xp = r2(goalOut.xp);
				goalOut.kills = r2(goalOut.kills);
				for (const k of CATS) goalOut.split[k] = r2(goalOut.split[k]);
				goalOut.end = r2(t);
				goalOut = null;
			});
			hold();
			step.end = r2(t);
			step.levelEnd = me.level;
			step.xpEnd = r2(me.xp);
			step.xp = r2(step.xp);
			for (const k of CATS) step.split[k] = r2(step.split[k]);
			step.k1 = Math.max(0, track.t.length - 1);
			step = null;
		});
		gOut.s1 = out.steps.length - 1;
		gOut.end = r2(t);
		gOut.levelEnd = me.level;
	}

	function playGoal(goal, quest, place, applies) {
		const v = goal.t;
		const line = goal._line;
		const skip = (reason) => {
			goalOut.skip = reason;
		};
		if (!applies) return skip('not for this character');
		// Optional goals never hold a step (docs/GUIDE_FORMAT.md). `optional`
		// false skips only those that are not quest work (rare kills, drops
		// without a quest, rep...); optional quest goals still play. true plays all.
		if (goal.optional && !optional && goal.quest == null && !['accept', 'turnin', 'complete'].includes(v)) return skip('optional');
		if (UNMODELLED.has(v)) {
			step.estimate = true;
			if (place.at) moveTo(place.at);
			return;
		}
		const entry = goal.quest != null ? log.get(goal.quest) || null : null;
		const objective = ['kill', 'collect', 'interact', 'use'].includes(v) && goal.quest != null;
		if ((v === 'turnin' || v === 'complete' || objective) && !entry) return skip('quest not in log');
		if (v === 'accept') {
			if (done.has(goal.quest)) return skip('quest already done');
			if (entry) return skip('quest already in the log');
		}
		if (v === 'level' && me.level >= goal.level) return skip(`already level ${goal.level}`);
		if (v === 'hearth' && !bind) {
			warn(line, 'hearth without a bind point (no `sethome` before it); skipped');
			return skip('no bind point');
		}
		const needsPlace = !['fly', 'hearth', 'level', 'complete'].includes(v);
		if (needsPlace && !place.at && v !== 'use') step.estimate = true;

		switch (v) {
			case 'accept': {
				moveTo(place.at);
				spend('interact', p.talkSec);
				if (goal.minLevel && me.level < goal.minLevel) warn(line, `${goalOut.quest.title} needs level ${goal.minLevel}; the character is ${me.level}`);
				const objectives = ((quest && quest.objectives) || []).map((o) => ({
					type: o.type, id: o.id != null ? Number(o.id) : null, text: o.text ? String(o.text) : o.type, cur: 0, max: Number(o.count) > 0 ? Number(o.count) : 1,
					at: o.map != null && o.x != null ? geo.toWorld(o.map, o.x, o.y, o.f === 'e' ? 'e' : 'l') : null,
				}));
				const e = { id: goal.quest, title: goalOut.quest.title, qlvl: goal.qlvl || (quest && quest.level > 0 ? quest.level : null), escort: isEscort(quest), objectives, ready: !objectives.length };
				log.set(goal.quest, e);
				event('accept', { quest: { id: e.id, title: e.title }, objectives: objectives.map((o) => ({ text: o.text, cur: 0, max: o.max })) });
				objectives.forEach((o, i) => o.type === 'item' && o.id != null && have(o.id) > 0 && setProgress(e, i, have(o.id)));
				if (pos) arrived();
				return;
			}
			case 'turnin': {
				moveTo(place.at);
				spend('interact', p.talkSec);
				const { full, estimate } = questFull(quest, entry, goal);
				if (estimate) step.estimate = true;
				const qlvl = questLevel(quest, entry.qlvl, me.level);
				const amount = Math.round(full * questXpShare(me.level, qlvl));
				// A kill objective on the quest's own giver or ender of the character's
				// side is a conversation's credit: talking to them now gives it.
				entry.objectives.forEach((o, i) => {
					if (o.type !== 'kill' || o.cur >= o.max || !quest) return;
					const npc = data.npc(o.id);
					const at = (ends) => !!(ends && (ends.npc || []).map(Number).includes(o.id));
					if (npc && npc.faction === SIDE_TAG[ch.faction] && (at(quest.start) || at(quest.end))) setProgress(entry, i, o.max);
				});
				if (!entry.ready) {
					const open = entry.objectives.filter((o) => o.cur < o.max).map((o) => `${o.text} ${o.cur}/${o.max}`);
					warn(line, `${entry.title} is turned in before the playback completes its objectives: ${open.join(', ')}`);
				}
				log.delete(goal.quest);
				done.add(goal.quest);
				out.totals.quests++;
				for (const o of entry.objectives) if (o.type === 'item' && o.id != null && have(o.id) > 0) setItem(o.id, null, have(o.id) - o.max);
				earn(amount, 'turnin', { quest: entry.id, title: entry.title });
				return;
			}
			case 'kill': {
				const oi = objectiveIndex(entry, goal, 'kill', goal.npc);
				let need = goal.count || 1;
				if (entry && oi >= 0) {
					const o = entry.objectives[oi];
					if (o.cur >= o.max) return skip('objective done');
					need = Math.min(need, o.max - o.cur);
				}
				moveTo(place.at);
				const base = entry && oi >= 0 ? entry.objectives[oi].cur : 0;
				const res = killWork(goal.npc != null ? goal.npc : null, need, {
					name: goal.target || null, radius: place.r, questId: goal.quest != null ? goal.quest : null, text: entry && oi >= 0 ? entry.objectives[oi].text : '',
					onTargetKills: entry && oi >= 0 ? (tk) => setProgress(entry, oi, Math.max(entry.objectives[oi].cur, base + tk)) : null,
				});
				if (entry && oi >= 0) setProgress(entry, oi, Math.max(entry.objectives[oi].cur, base + need));
				goalOut.kills += res.kills;
				goalOut.spawns = res.spawns;
				return;
			}
			case 'collect': {
				const oi = objectiveIndex(entry, goal, 'item', goal.item);
				let need;
				if (entry && oi >= 0) {
					const o = entry.objectives[oi];
					if (o.cur >= o.max) return skip('objective done');
					need = o.max - Math.min(o.max, have(goal.item));
				} else need = (goal.count || 1) - have(goal.item);
				if (need <= 0) return skip('already in the bags');
				moveTo(place.at);
				if (Array.isArray(goal.candidates) && goal.x == null && place.at && place.at.cand) {
					// A farm spot (`collect … nearest`): kills by its drop rate.
					const c = place.at.cand;
					const rate = Math.max(0.001, (Number(c.rate) || 0.1) * p.dropMul);
					const lvl = c.lvl ? Math.round((c.lvl.min + c.lvl.max) / 2) : me.level;
					const start = have(goal.item);
					const res = killWork(c.npc != null ? Number(c.npc) : null, need / rate, {
						name: c.npcName || null, radius: place.r, level: lvl,
						onTargetKills: (tk, k, n) => setItem(goal.item, goal.itemName, start + Math.min(need, (Math.min(k, n) / n) * need)),
					});
					setItem(goal.item, goal.itemName, start + need);
					goalOut.kills += res.kills;
					goalOut.spawns = res.spawns;
					return;
				}
				const res = collectWork(goal.item, goal.itemName, need, place.r, !!place.at);
				if (res.estimate) step.estimate = true;
				goalOut.kills += res.kills;
				goalOut.spawns = res.spawns;
				return;
			}
			case 'interact': {
				const oi = objectiveIndex(entry, goal, 'object', goal.object);
				let need = goal.count || 1;
				if (entry && oi >= 0) {
					const o = entry.objectives[oi];
					if (o.cur >= o.max) return skip('objective done');
					if (!goal.count) need = o.max - o.cur;
				}
				moveTo(place.at);
				const base = entry && oi >= 0 ? entry.objectives[oi].cur : 0;
				goalOut.spawns = farm('object', goal.object, goal.objName || `object ${goal.object}`, need, place.r, (k, frac) => {
					spend('interact', p.interactSec * frac);
					if (entry && oi >= 0) setProgress(entry, oi, base + k);
				}, 0);
				if (entry && oi >= 0) setProgress(entry, oi, Math.max(entry.objectives[oi].cur, base + need));
				return;
			}
			case 'use': {
				const oi = objectiveIndex(entry, goal, null, null);
				if (entry && oi >= 0 && entry.objectives[oi].cur >= entry.objectives[oi].max) return skip('objective done');
				moveTo(place.at);
				spend('interact', p.interactSec * (goal.count || 1));
				if (entry && oi >= 0) setProgress(entry, oi, entry.objectives[oi].max);
				return;
			}
			case 'complete': {
				if (place.at) moveTo(place.at);
				entry.objectives.forEach((o, i) => {
					const need = o.max - o.cur;
					if (need <= 0) return;
					if (o.type === 'kill' && o.id != null) {
						if (!place.at) {
							const pts = spawnsOf('npc', o.id);
							if (pts.length) moveTo(nearest(pts));
							else step.estimate = true;
						}
						const res = killWork(o.id, need, { name: npcInfo(o.id).name, radius: place.r, questId: entry.id, text: o.text });
						goalOut.kills += res.kills;
						if (!goalOut.spawns) goalOut.spawns = res.spawns;
						setProgress(entry, i, o.max);
					} else if (o.type === 'item' && o.id != null) {
						const it = data.item(o.id);
						const res = collectWork(o.id, it && it.name ? String(it.name) : o.text, o.max - Math.min(o.max, have(o.id)), place.r, !!place.at);
						if (res.estimate) step.estimate = true;
						goalOut.kills += res.kills;
						if (!goalOut.spawns) goalOut.spawns = res.spawns;
					} else if (o.type === 'object' && o.id != null) {
						if (!place.at) {
							const pts = spawnsOf('object', o.id);
							if (pts.length) moveTo(nearest(pts));
						}
						const obj = data.object(o.id);
						const sp = farm('object', o.id, obj && obj.name ? String(obj.name) : o.text, need, place.r, () => spend('interact', p.interactSec), 0);
						if (!goalOut.spawns) goalOut.spawns = sp;
						setProgress(entry, i, o.max);
					} else {
						if (o.at && !place.at) moveTo(o.at);
						if (entry.escort || !o.at) spend('combat', p.escortSec);
						setProgress(entry, i, o.max);
					}
				});
				return;
			}
			case 'level': {
				moveTo(place.at);
				hold();
				let kills = 0;
				while (me.level < goal.level && me.level < MAX_LEVEL) {
					const L = me.level;
					let best = null;
					for (let d = 0; d <= 2; d++) {
						const xpk = mobXp(L, L + d) * (1 + p.restedShare);
						const sec = killSec(L, L + d, false);
						if (xpk > 0 && (!best || xpk / sec > best.rate)) best = { rate: xpk / sec, xpk };
					}
					const needXp = LEVEL_XP[L] - me.xp;
					spend('combat', needXp / (best.rate * p.grindEff));
					kills += needXp / best.xpk;
					earn(needXp, 'grind', {});
				}
				goalOut.kills += kills;
				if (pos) sample(MODES.fight);
				return;
			}
			case 'fly': {
				const nodes = net.nodes;
				const destIdx = nodes.indexOf(named(nodes, goal.location));
				if (destIdx < 0) {
					warn(line, `no ${ch.faction} flight master named "${goal.location}" in travel.json; skipped`);
					return skip('unknown flight destination');
				}
				const dest = nodes[destIdx];
				goalOut.at = { c: dest.c, wx: r1(dest.wx), wy: r1(dest.wy), map: dest.map, x: dest.x, y: dest.y, f: 'e' };
				if (!pos) {
					moveTo(dest);
					return;
				}
				const { dist: dd, next, path: via } = flightsTo(net, destIdx);
				// The flight master to start from: the quickest way there plus the flight
				// (the nearest one in practice; across the sea, the one past the boat).
				let origin = -1;
				let best = Infinity;
				nodes.forEach((n, i) => {
					if (dd[i] === Infinity) return;
					const w = way(pos, n);
					const sec = w ? w.sec + dd[i] + (i === destIdx ? 0 : p.flightOverhead) : Infinity;
					if (sec < best) {
						best = sec;
						origin = i;
					}
				});
				if (origin < 0) {
					warn(line, `no way to the flight master at ${dest.short || dest.name} from continent ${pos.c}; teleported`);
					moveTo(dest);
					return;
				}
				moveTo(nodes[origin]);
				if (origin === destIdx) return;
				hold();
				spend('travel', p.flightOverhead);
				hold();
				event('fly', { from: nodes[origin].short || nodes[origin].name, to: dest.short || dest.name });
				for (let i = origin; i !== destIdx; ) {
					const j = next[i];
					flyLeg(nodes[j], dd[i] - dd[j], via[i]);
					i = j;
				}
				arrived();
				return;
			}
			case 'hearth': {
				if (hearthAt != null && hearthAt > t) {
					warn(line, `hearthstone on cooldown for ${Math.ceil((hearthAt - t) / 60)} more minutes; waited`);
					hold();
					spend('wait', hearthAt - t);
				}
				hold();
				spend('travel', p.hearthCast);
				hold();
				pos = { c: bind.c, wx: bind.wx, wy: bind.wy };
				sample(MODES.teleport);
				hearthAt = t + p.hearthCooldown;
				event('hearth', { readyAt: r2(hearthAt), to: bind.name });
				goalOut.at = { c: bind.c, wx: r1(bind.wx), wy: r1(bind.wy), map: bind.map, x: bind.x, y: bind.y, f: bind.f };
				arrived();
				return;
			}
			case 'sethome': {
				const inn = named(net.inns, goal.location);
				const at = place.at || (inn ? worldOf(inn.map, inn.x, inn.y, inn.f) || { c: inn.c, wx: inn.wx, wy: inn.wy, map: inn.map, x: inn.x, y: inn.y, f: inn.f || 'e' } : null);
				if (at && !goalOut.at) goalOut.at = { c: at.c, wx: r1(at.wx), wy: r1(at.wy), map: at.map, x: at.x, y: at.y, f: at.f };
				moveTo(at);
				spend('interact', p.talkSec);
				const b = inn || null;
				const spot = b ? { c: b.c, wx: b.wx, wy: b.wy, map: b.map, x: b.x, y: b.y, f: b.f || 'e' } : at || pos;
				if (!spot) {
					warn(line, 'sethome without a place; no bind point');
					return;
				}
				const name = goal.location || (b && b.location) || goal.npcName || (place.at && place.at.map != null ? geo.zoneName(place.at.map) : null) || 'bind point';
				bind = { name, c: spot.c, wx: spot.wx, wy: spot.wy, map: spot.map != null ? spot.map : null, x: spot.x != null ? spot.x : null, y: spot.y != null ? spot.y : null, f: spot.f || null };
				event('bind', { name, c: bind.c, wx: r1(bind.wx), wy: r1(bind.wy) });
				return;
			}
			case 'getfp': {
				const node = named(net.nodes, goal.location);
				let at = place.at;
				if (!at && node) {
					at = { c: node.c, wx: node.wx, wy: node.wy, map: node.map, x: node.x, y: node.y, f: 'e' };
					goalOut.at = { ...at, wx: r1(at.wx), wy: r1(at.wy) };
				}
				moveTo(at);
				spend('interact', p.talkSec);
				let name = goal.location || null;
				if (!name && pos) {
					const near = nearest(net.nodes.filter((n) => n.c === pos.c));
					if (near && dist(near, pos) < 200) name = near.short || near.name;
				}
				name = name || goal.npcName || 'flight path';
				if (!fps.includes(name)) {
					fps.push(name);
					event('fp', { name });
				}
				return;
			}
			case 'buy': {
				moveTo(place.at);
				spend('interact', p.talkSec);
				if (goal.item != null) setItem(goal.item, goal.itemName, have(goal.item) + (goal.count || 1));
				return;
			}
			default: {
				// talk, train, vendor, learn, goto, explore
				moveTo(place.at);
				if (TALK.has(v)) spend('interact', p.talkSec);
				// A conversation is the credit of a kill objective on that NPC.
				if (v === 'talk' && goal.npc != null) {
					for (const q of log.values()) q.objectives.forEach((o, i) => o.type === 'kill' && o.id === Number(goal.npc) && setProgress(q, i, o.max));
				}
			}
		}
	}

	out.totals.seconds = r2(t);
	for (const k of CATS) out.totals.split[k] = r2(out.totals.split[k]);
	out.totals.level = me.level;
	out.totals.xp = r2(me.xp);
	out.totals.routeSeconds = r2(out.totals.routeSeconds);
	out.totals.estimateSeconds = r2(out.totals.estimateSeconds);
	return out;
}

module.exports = { buildTimeline, routeOf, loadParams, goalLabel, appliesTo, HOME, MODES };
