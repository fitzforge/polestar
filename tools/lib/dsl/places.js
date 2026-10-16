'use strict';
// The location of `sethome`, `hearth`, `fly` and `getfp` against the places
// the game can report, matched the way the addon matches it
// (addon/Polestar/Core/Engine.lua, goalDone), ignoring case:
//   sethome  GetBindLocation() equals it: an inn's bind location
//   hearth   the zone or subzone text equals it on arrival: an inn's area or
//            the zone an inn stands in
//   fly      the zone or subzone text equals it on arrival: a flight point's
//            town, an inn's area or the zone a flight point stands in
//   getfp    a learned flight point's name ("Stormwind, Elwynn") equals it,
//            or its part before the first comma does
// Inns and flight points come from travel.json, zone names from zones.json.
// A kind of place the data has nothing for is not checked.
//
// Places by ID (docs/GUIDE_FORMAT.md, "Places by ID"): the game names places
// in the player's language, so a goal naming a place also gets its ID, and
// the addon compares like with like:
//   area  sethome, hearth, fly, getfp: the area their location names; goto:
//         the one its label names. From the client's AreaTable
//         (tools/lib/data/areas.js), in the goal's zone when it has a map.
//         The addon compares the zone and subzone text (and the bind
//         location) with C_Map.GetAreaInfo(area) and shows that name.
//   node  getfp: the taxi node (travel.json) of the flight master it names,
//         else the one node of that name or town serving every faction the
//         goal applies to. The addon checks the nodes the flight map lists.
// A name with no single match gets neither; the goal keeps its name match.
//
// A `sethome` naming no npc gets its inn's innkeeper (goalInnkeeper): of the
// inns (travel.json) the location names, the one whose innkeeper serves every
// faction the goal applies to, so the arrow has someone to lead to.

const { areaNamed } = require('../data/areas');
const { factionTag, usableBy } = require('./candidates');

const DATA = new WeakMap();

// The part of a flight point's name before its first comma, as the addon reads it.
const town = (name) => String(name).split(',')[0];

function zoneOf(data, map) {
	const z = map != null ? data.zone(map) : null;
	return z && z.name ? String(z.name) : null;
}

// verb -> { accepts(lowercased location) -> bool, names (suggestions) } | null
function placesOf(data) {
	if (DATA.has(data)) return DATA.get(data);
	const inns = data.inns();
	const nodes = data.flightNodes();
	const innNames = inns.flatMap((i) => (Array.isArray(i.names) && i.names.length ? i.names : [i.location]).map(String));
	const set = (names) => {
		const list = [...new Set(names.filter(Boolean))].sort();
		const lower = new Set(list.map((n) => n.toLowerCase()));
		return { names: list, accepts: (l) => lower.has(l) };
	};
	const out = {};
	if (inns.length) {
		out.sethome = set(innNames);
		out.hearth = set([...innNames, ...inns.map((i) => zoneOf(data, i.map))]);
	}
	if (nodes.length) {
		out.fly = set([...nodes.map((n) => town(n.name)), ...innNames, ...nodes.map((n) => zoneOf(data, n.map))]);
		const full = set(nodes.map((n) => String(n.name)));
		const towns = set(nodes.map((n) => town(n.name)));
		out.getfp = { names: towns.names, accepts: (l) => full.accepts(l) || towns.accepts(l) };
	}
	DATA.set(data, out);
	return out;
}

function distance(a, b) {
	let prev = Array.from({ length: b.length + 1 }, (_, j) => j);
	for (let i = 1; i <= a.length; i++) {
		const row = [i];
		for (let j = 1; j <= b.length; j++) row[j] = Math.min(prev[j] + 1, row[j - 1] + 1, prev[j - 1] + (a[i - 1] === b[j - 1] ? 0 : 1));
		prev = row;
	}
	return prev[b.length];
}

// Up to three known names closest to `location`: names holding it (or held
// by it) first, then by spelling distance.
function closest(location, names) {
	const want = location.toLowerCase();
	const scored = [];
	for (const name of names) {
		const n = name.toLowerCase();
		if (n.includes(want) || want.includes(n)) scored.push({ name, score: Math.abs(n.length - want.length) / 100 });
		else {
			const d = distance(want, n);
			if (d <= Math.max(2, Math.floor(want.length / 3))) scored.push({ name, score: d });
		}
	}
	return scored.sort((a, b) => a.score - b.score || (a.name < b.name ? -1 : 1)).slice(0, 3).map((s) => s.name);
}

const WHAT = {
	sethome: ['no inn has that bind location', 'inn'],
	hearth: ['no inn stands there (an inn\'s area or the zone it is in)', 'inn'],
	fly: ['no flight point lands there (its town, an inn\'s area or the zone it is in)', 'flight'],
	getfp: ['no flight point has that name', 'flight'],
};

// -> null when the location can match (or there is no data for the verb),
// else { message, hint } for the warning.
function checkLocation(data, verb, location) {
	const places = data && typeof data.inns === 'function' ? placesOf(data)[verb] : null;
	if (!places || typeof location !== 'string' || places.accepts(location.toLowerCase())) return null;
	const [why, kind] = WHAT[verb];
	const near = closest(location, places.names);
	const lookUp = `\`polestar find --kind ${kind}\` lists every ${kind === 'inn' ? 'inn' : 'flight point'}`;
	return {
		message: `${verb} "${location}": ${why}; the game never reports that name, so the goal never checks off by itself`,
		hint: near.length ? `did you mean ${near.map((n) => `"${n}"`).join(' or ')}? (${lookUp})` : lookUp,
	};
}

// The verbs whose `location` names a place; `goto` names one with its label.
const LOCATION_VERBS = new Set(['sethome', 'hearth', 'fly', 'getfp']);
// travel.json faction mask bits.
const SIDE_MASK = { Alliance: 1, Horde: 2 };

// The name a goal's area is found by, or null.
function placeName(goal) {
	if (LOCATION_VERBS.has(goal.t)) return typeof goal.location === 'string' ? goal.location : null;
	if (goal.t === 'goto') return typeof goal.text === 'string' ? goal.text : null;
	return null;
}

// A goal's area ID, or undefined: the one area its place name stands for, in
// the zone of its map when it has one.
function goalArea(data, goal) {
	const name = placeName(goal);
	if (!name || !data.areas) return undefined;
	const zone = goal.map !== undefined ? data.zone(goal.map) : null;
	const area = areaNamed(data.areas, name, zone && zone.areaId);
	return area ? area.id : undefined;
}

// A getfp's taxi node ID, or undefined: the node of its flight master
// (`npc`), else the one node whose name or town is its location and that
// serves every faction in `sides` (the factions the goal applies to).
function goalNode(data, goal, sides) {
	if (goal.t !== 'getfp' || typeof goal.location !== 'string') return undefined;
	const nodes = data.flightNodes();
	if (goal.npc !== undefined) {
		const own = nodes.filter((n) => n.npc === goal.npc);
		if (own.length === 1) return own[0].id;
	}
	const want = goal.location.trim().toLowerCase();
	const mask = (sides || []).reduce((m, s) => m | (SIDE_MASK[s] || 0), 0);
	const named = nodes.filter((n) => {
		const full = String(n.name).toLowerCase();
		return (full === want || town(full) === want) && (n.faction & mask) === mask;
	});
	return named.length === 1 ? named[0].id : undefined;
}

// A sethome's innkeeper, or null: the npc of the one inn (travel.json) whose
// bind location (any of its names, ignoring case) is `location` and whose
// innkeeper serves every faction in `sides` (neutral towns' goblins serve
// both: candidates.js factionTag).
function goalInnkeeper(data, location, sides) {
	if (typeof location !== 'string') return null;
	const want = location.trim().toLowerCase();
	const named = data.inns().filter((i) => {
		if (!(Number(i.npc) > 0)) return false;
		const names = Array.isArray(i.names) && i.names.length ? i.names : [i.location];
		if (!names.some((n) => String(n).toLowerCase() === want)) return false;
		const tag = factionTag(data.npc(i.npc) || { faction: null, roles: ['innkeeper'] });
		return (sides || []).every((s) => usableBy(tag, s));
	});
	return named.length === 1 ? { npc: Number(named[0].npc), npcName: named[0].npcName || null } : null;
}

// -> { places, withArea, getfp, withNode }: goals naming a place and how many
// got an area; getfp goals and how many got a taxi node.
function placeCounts(guides) {
	const out = { places: 0, withArea: 0, getfp: 0, withNode: 0 };
	for (const g of guides) {
		for (const step of g.steps || []) {
			for (const goal of step.goals || []) {
				if (placeName(goal) !== null) {
					out.places++;
					if (goal.area !== undefined) out.withArea++;
				}
				if (goal.t === 'getfp') {
					out.getfp++;
					if (goal.node !== undefined) out.withNode++;
				}
			}
		}
	}
	return out;
}

module.exports = { checkLocation, goalArea, goalNode, goalInnkeeper, placeCounts };
