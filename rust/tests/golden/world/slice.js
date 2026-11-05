'use strict';
// Cuts the shareable data/forever slice of rust/tests/golden/world/forever from a full JS
// `data build --offline --no-questie --no-web-zones --no-web-xp` output (pfQuest MIT, Blizzard
// client tables, CMaNGOS classic-db heights) plus this checkout's curated trainers.json.
// Not run in CI. usage: node slice.js <full data build dir> <trainers.json> <travel.json> <out dir>
//
// Kept: quests of the slice's zones (their quest zone, or a giver/ender spawned there), the
// NPCs and objects spawned in those zones or named by a kept quest (spawns cut to the slice's
// maps), the items a kept quest names or a kept NPC/object drops or sells for a kept quest,
// their spawnz heights, taxi nodes/legs and inns on the slice's maps; whole client tables
// (zones, map-frames, factions, races, instances) and meta.json. dungeons.json is synthetic
// (no DungeonJournal data).
const fs = require('node:fs');
const path = require('node:path');

const ZONES = new Set([1411, 1413, 1454, 1429, 1453]); // Durotar, The Barrens, Orgrimmar, Elwynn Forest, Stormwind City
const [src, trainersFile, travelFile, out] = process.argv.slice(2);
const rd = (f) => JSON.parse(fs.readFileSync(path.join(src, f), 'utf8'));
const quests = rd('quests.json'), npcs = rd('npcs.json'), objects = rd('objects.json'), items = rd('items.json'), spawnz = rd('spawnz.json');
const inZone = (rec) => rec && Object.keys(rec.spawns || {}).some((m) => ZONES.has(Number(m)));

const keepQ = {};
for (const [id, q] of Object.entries(quests)) {
	const ends = [...q.start.npc, ...q.end.npc].map((n) => npcs[n]).concat([...q.start.object, ...q.end.object].map((o) => objects[o]));
	if (ZONES.has(q.zone) || ends.some(inZone)) keepQ[id] = q;
}
const npcIds = new Set(), objIds = new Set(), itemIds = new Set();
for (const q of Object.values(keepQ)) {
	q.start.npc.forEach((n) => npcIds.add(String(n)));
	q.end.npc.forEach((n) => npcIds.add(String(n)));
	q.start.object.forEach((o) => objIds.add(String(o)));
	q.end.object.forEach((o) => objIds.add(String(o)));
	q.start.item.forEach((i) => itemIds.add(String(i)));
	for (const o of q.objectives) {
		if (o.type === 'kill') npcIds.add(String(o.id));
		else if (o.type === 'object') objIds.add(String(o.id));
		else if (o.type === 'item') itemIds.add(String(o.id));
	}
}
for (const [id, n] of Object.entries(npcs)) if (inZone(n)) npcIds.add(id);
for (const [id, o] of Object.entries(objects)) if (inZone(o)) objIds.add(id);
const cut = (rec) => {
	if (!rec.spawns) return rec;
	const spawns = {};
	for (const [m, s] of Object.entries(rec.spawns)) if (ZONES.has(Number(m))) spawns[m] = s;
	return { ...rec, spawns };
};
const pick = (all, ids, f = (x) => x) => Object.fromEntries(Object.keys(all).filter((k) => ids.has(k)).map((k) => [k, f(all[k])]));
const keepN = pick(npcs, npcIds, cut), keepO = pick(objects, objIds, cut);
// Items: a kept quest's, with their drops and vendors cut to kept NPCs/objects.
const keepI = {};
for (const id of Object.keys(items)) {
	if (!itemIds.has(id)) continue;
	const it = items[id];
	const drops = { npc: Object.fromEntries(Object.entries(it.drops.npc).filter(([n]) => keepN[n])), object: Object.fromEntries(Object.entries(it.drops.object).filter(([o]) => keepO[o])) };
	keepI[id] = { ...it, drops, vendors: (it.vendors || []).filter((v) => keepN[String(v)]) };
}
const sz = { npc: pick(spawnz.npc, npcIds), object: pick(spawnz.object, objIds) };

// Travel: client-table taxi nodes and legs, and inns, on the slice's maps.
const travel = JSON.parse(fs.readFileSync(travelFile, 'utf8'));
const nodes = travel.taxi.nodes.filter((n) => ZONES.has(n.map));
const nodeIds = new Set(nodes.map((n) => n.id));
const legs = travel.taxi.legs.filter((l) => nodeIds.has(l.from) && nodeIds.has(l.to));
const trav = {
	schema: travel.schema, build: travel.build, foreverBuild: travel.foreverBuild, transitBuild: travel.transitBuild, cmangosRev: travel.cmangosRev, areaBuild: travel.areaBuild,
	sources: travel.sources.filter((s) => /client tables|pfQuest|map-frames/.test(s.name)),
	counts: { taxiNodes: nodes.length, flights: legs.length, transports: 0, inns: 0, pathNodes: 0, pathEdges: 0, recordedCrossings: 0, shippedCrossings: 0, timetables: 0, portals: 0, teleports: 0 },
	taxi: { nodes, legs }, transports: [], inns: travel.inns.filter((i) => ZONES.has(i.map)), paths: { nodes: [], edges: [], sessions: [] },
};
trav.counts.inns = trav.inns.length;

fs.mkdirSync(out, { recursive: true });
const wr = (f, v) => fs.writeFileSync(path.join(out, f), JSON.stringify(v));
wr('quests.json', keepQ); wr('npcs.json', keepN); wr('objects.json', keepO); wr('items.json', keepI); wr('spawnz.json', sz); wr('travel.json', trav);
wr('trainers.json', JSON.parse(fs.readFileSync(trainersFile, 'utf8')));
wr('dungeons.json', { source: { name: 'synthetic', license: null }, dungeons: [] });
for (const f of ['zones.json', 'map-frames.json', 'factions.json', 'races.json', 'instances.json', 'meta.json']) fs.copyFileSync(path.join(src, f), path.join(out, f));
console.error(`slice: ${Object.keys(keepQ).length} quests, ${Object.keys(keepN).length} npcs, ${Object.keys(keepO).length} objects, ${Object.keys(keepI).length} items, ${nodes.length} taxi nodes, ${legs.length} legs`);
