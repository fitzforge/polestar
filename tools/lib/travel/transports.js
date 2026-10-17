'use strict';
// Boats, zeppelins and the Deeprun Tram. Which transports exist and who
// rides them is curated (Era facts, plus the ships WoW Forever added); where
// they stop and how long they take comes from data:
//
// - Each boat/zeppelin runs a looping TaxiPath (Blizzard TaxiPathNode; the
//   Classic Era client's, or the WoW Forever client's for `client: 'forever'`
//   ships). Its stops are the points with Flags & 2 and a Delay (seconds
//   docked). The stop in each end's zone is that end's dock, checked against
//   the zone's map rectangle.
// - Where an NPC stands at the boarding point (zeppelin masters, the
//   wharfmasters), that NPC's spawn (data/forever/npcs.json) is the dock the
//   player walks to, and it must lie within ANCHOR_YARDS of the stop and on
//   the end's zone map. Other anchors only check the stop.
// - Ride time = loop distance between the two stops / TRANSPORT_SPEED plus a
//   loading screen per continent change or teleport, plus the Delay of every
//   stop the ship calls at on the way (a loop with three docks); the expected
//   wait is half a full cycle (sailing the whole loop plus every docked Delay).
//   A ship calling at three docks is one transport per pair of consecutive
//   docks; each direction follows the loop, so the long way round passes the
//   third dock.
// - The tram has no taxi path: its ends are the AreaTrigger instance portals
//   in Stormwind (2173) and Ironforge (2175), and its ride is the distance
//   between the two portals inside the tram instance (2166 and 2171).
// - An end is placed on its map's Era frame (f "e") unless Forever redrew that
//   map (its live frame differs, e.g. Stormwind with the harbor) or Forever
//   added it (the Riverglades): then on the live frame (f "l").

const { round, dist2d, isJump } = require('./geo');
const { spawnPoints, indexByName } = require('./entities');
const { pathPoints } = require('./taxi');

// Estimates, not client data: transports carry their speed in server-side
// gameobject data. 30 yd/s matches the common Classic transport speed.
const TRANSPORT_SPEED = 30;
const LOAD_SECONDS = 10;
const TRAM_WAIT = 30; // two trams shuttle continuously
const ANCHOR_YARDS = 120;
const STOP_MERGE_YARDS = 40;

const A = 1;
const H = 2;
const BOTH = 3;

// path: TaxiPath ID in the Era client tables, or the Forever client tables
// with client: 'forever'. An end's area: the AreaTable area of its place (the
// WoW Forever client's), whose name the client gives in its language
// (C_Map.GetAreaInfo); name is the English one, for logs and enUS.
const TRANSPORTS = [
	{
		id: 'boat-bootybay-ratchet', kind: 'boat', faction: BOTH, path: 241,
		a: { name: 'Booty Bay', area: 35, zone: 1434, anchor: { npc: 'Wharfmaster Lozgil', use: 'position' } },
		b: { name: 'Ratchet', area: 392, zone: 1413, anchor: { npc: 'Wharfmaster Dizzywig', use: 'position' } },
	},
	{
		id: 'boat-menethil-theramore', kind: 'boat', faction: A, path: 292,
		a: { name: 'Menethil Harbor', area: 150, zone: 1437, anchor: { object: 'Boat to Theramore', use: 'check' } },
		b: { name: 'Theramore', area: 513, zone: 1445 },
	},
	// Forever ships (TaxiPath IDs of the Forever client). One ship sails
	// Menethil Harbor -> Southshore -> Auberdine -> Menethil Harbor (TaxiPath
	// 11167); it replaced the Era Menethil-Auberdine boat (TaxiPath 295, still
	// in the client tables), so that pair keeps its id and rides the new loop.
	{
		id: 'boat-menethil-southshore', kind: 'boat', faction: A, client: 'forever', path: 11167,
		a: { name: 'Menethil Harbor', area: 150, zone: 1437 },
		b: { name: 'Southshore', area: 271, zone: 1424 },
	},
	{
		id: 'boat-southshore-auberdine', kind: 'boat', faction: A, client: 'forever', path: 11167,
		a: { name: 'Southshore', area: 271, zone: 1424 },
		b: { name: 'Auberdine', area: 442, zone: 1439, anchor: { object: 'Boat to Menethil', use: 'check' } },
	},
	{
		id: 'boat-menethil-auberdine', kind: 'boat', faction: A, client: 'forever', path: 11167,
		a: { name: 'Menethil Harbor', area: 150, zone: 1437 },
		b: { name: 'Auberdine', area: 442, zone: 1439, anchor: { object: 'Boat to Menethil', use: 'check' } },
	},
	{
		id: 'boat-stormwind-auberdine', kind: 'boat', faction: A, client: 'forever', path: 11616,
		a: { name: 'Stormwind Harbor', area: 17203, zone: 1453 },
		b: { name: 'Auberdine', area: 442, zone: 1439 },
	},
	{
		id: 'boat-tanaris-powderfuse', kind: 'boat', faction: BOTH, client: 'forever', path: 11391,
		a: { name: 'Steamwheedle Port', area: 977, zone: 1446, anchor: { npc: 'Wharfmaster Steamfizzle', use: 'position' } },
		b: { name: 'Powderfuse Port', area: 16727, zone: 2548, anchor: { npc: 'Wharfmaster Whizzbuzz', use: 'position' } },
	},
	{
		id: 'boat-auberdine-ruttheran', kind: 'boat', faction: A, path: 293,
		a: { name: 'Auberdine', area: 442, zone: 1439, anchor: { object: 'Boat to Teldrassil', use: 'check' } },
		b: { name: "Rut'theran Village", area: 702, zone: 1438 },
	},
	{
		id: 'boat-feathermoon', kind: 'boat', faction: A, path: 303,
		a: { name: 'Feathermoon Stronghold', area: 1116, zone: 1444, near: [31, 39.5] },
		b: { name: 'The Forgotten Coast', area: 1108, zone: 1444, near: [43, 43] },
	},
	{
		id: 'zeppelin-orgrimmar-undercity', kind: 'zeppelin', faction: H, path: 302,
		a: { name: 'Orgrimmar', area: 1637, zone: 1411, anchor: { npc: 'Frezza', use: 'position' } },
		b: { name: 'Undercity', area: 1497, zone: 1420, anchor: { npc: 'Zapetta', use: 'position' } },
	},
	{
		id: 'zeppelin-orgrimmar-gromgol', kind: 'zeppelin', faction: H, path: 285,
		a: { name: 'Orgrimmar', area: 1637, zone: 1411, anchor: { npc: 'Snurk Bucksquick', use: 'position' } },
		b: { name: "Grom'gol", area: 117, zone: 1434, anchor: { npc: "Nez'raz", use: 'position' } },
	},
	{
		id: 'zeppelin-undercity-gromgol', kind: 'zeppelin', faction: H, path: 301,
		a: { name: 'Undercity', area: 1497, zone: 1420, anchor: { npc: 'Hin Denburg', use: 'position' } },
		b: { name: "Grom'gol", area: 117, zone: 1434, anchor: { npc: 'Squibby Overspeck', use: 'position' } },
	},
	{
		id: 'tram-stormwind-ironforge', kind: 'tram', faction: A,
		a: { name: 'Stormwind', area: 1519, zone: 1453, trigger: 2173 },
		b: { name: 'Ironforge', area: 1537, zone: 1455, trigger: 2175 },
		inside: [2166, 2171],
	},
];

function num(v) {
	const n = Number(v);
	return Number.isFinite(n) ? n : null;
}

// Docked stops of a loop, nearby duplicates merged: [{ wx, wy, c, idx: [..], delay }].
// Some loops list a stretch twice (TaxiPath 303 repeats points 0-2 as 19-21),
// so one stop can own several indices; its delay counts once.
function stopsOf(points) {
	const stops = [];
	points.forEach((p, k) => {
		if (!(p.flags & 2) || !p.delay) return;
		const same = stops.find((s) => s.c === p.c && dist2d(s, p) <= STOP_MERGE_YARDS);
		if (same) {
			same.idx.push(k);
			same.delay = Math.max(same.delay, p.delay);
		} else {
			stops.push({ c: p.c, wx: p.wx, wy: p.wy, idx: [k], delay: p.delay });
		}
	});
	return stops;
}

// Shortest sail from any index of stop `from` to any index of stop `to`,
// with the other stops it calls at on the way.
function sailBetween(points, stops, from, to) {
	const stopAt = new Map();
	for (const s of stops) for (const k of s.idx) stopAt.set(k, s);
	let best = null;
	for (const i of from.idx) {
		for (const j of to.idx) {
			const leg = sail(points, i, j, stopAt, [from, to]);
			if (!best || leg.teleports < best.teleports || (leg.teleports === best.teleports && leg.yards < best.yards)) best = leg;
		}
	}
	return best;
}

// Sail from point index i to j along the loop (wrapping): yards, teleports
// and the docked seconds of stops passed on the way (other than `ends`).
function sail(points, i, j, stopAt, ends) {
	let yards = 0;
	let teleports = 0;
	const calls = new Set();
	const n = points.length;
	for (let k = i; k !== j; k = (k + 1) % n) {
		const s = k !== i && stopAt.get(k);
		if (s && !ends.includes(s)) calls.add(s);
		const a = points[k];
		const b = points[(k + 1) % n];
		if (isJump(a, b)) teleports++;
		else yards += Math.hypot(b.wx - a.wx, b.wy - a.wy, b.z - a.z);
	}
	let docked = 0;
	for (const s of calls) docked += s.delay;
	return { yards, teleports, docked };
}

const sameFrame = (a, b) => a.c === b.c && ['left', 'right', 'top', 'bottom'].every((k) => Math.abs(a[k] - b[k]) < 0.01);

// The frame an end's map percent is given in: Era ("e"), or live ("l") where
// Forever added the map or redrew it.
function zoneFrame(frames, liveFrames, zone) {
	const era = frames.frame(zone);
	const live = liveFrames.get(zone);
	if (live && (!era || !sameFrame(era, live))) return { b: live, f: 'l' };
	return era ? { b: era, f: 'e' } : null;
}

function inZone(frames, liveFrames, zone, c, wx, wy) {
	const z = zoneFrame(frames, liveFrames, zone);
	if (!z || z.b.c !== c) return null;
	const x = ((wy - z.b.left) / (z.b.right - z.b.left)) * 100;
	const y = ((wx - z.b.top) / (z.b.bottom - z.b.top)) * 100;
	return x >= 0 && x <= 100 && y >= 0 && y <= 100 ? { x, y, f: z.f } : null;
}

function findAnchor(anchor, indexes, frames, liveFrames, zone) {
	const list = anchor.npc ? indexes.npcs.get(anchor.npc) : indexes.objects.get(anchor.object);
	const label = anchor.npc ? `npc "${anchor.npc}"` : `object "${anchor.object}"`;
	if (!list || !list.length) return { error: `${label} not found` };
	const pts = [];
	for (const e of list) for (const p of spawnPoints(e, frames, liveFrames)) if (p.map === zone) pts.push({ ...p, id: e.id });
	if (!pts.length) return { error: `${label} does not spawn on map ${zone}` };
	return { label, pts, kind: anchor.npc ? 'npc' : 'object' };
}

function endpoint(end, frames, liveFrames, stop, anchorInfo, warnings, id) {
	const zoneName = frames.name(end.zone) || String(end.zone);
	let source;
	let pos;
	if (anchorInfo && !anchorInfo.error) {
		let best = anchorInfo.pts[0];
		if (stop) for (const p of anchorInfo.pts) if (dist2d(p, stop) < dist2d(best, stop)) best = p;
		const d = stop ? dist2d(best, stop) : 0;
		if (stop && d > ANCHOR_YARDS) {
			warnings.push(`${id}: ${anchorInfo.label} is ${Math.round(d)} yd from the ${end.name} stop; stop used`);
		} else if (end.anchor.use === 'position') {
			pos = { c: best.c, wx: best.wx, wy: best.wy };
			source = `${anchorInfo.kind} ${best.id} (${anchorInfo.label.replace(/^\w+ /, '')})${stop ? `, ${Math.round(d)} yd from the TaxiPathNode stop` : ''}`;
		} else {
			source = `TaxiPathNode stop, checked against ${anchorInfo.label} (${Math.round(d)} yd)`;
		}
	} else if (anchorInfo && anchorInfo.error) {
		warnings.push(`${id}: ${anchorInfo.error}`);
	}
	if (!pos) {
		if (!stop) return null;
		pos = { c: stop.c, wx: stop.wx, wy: stop.wy };
		source = source || 'TaxiPathNode stop';
	}
	const m = inZone(frames, liveFrames, end.zone, pos.c, pos.wx, pos.wy);
	if (!m) {
		warnings.push(`${id}: ${end.name} dock is not on ${zoneName}`);
		return null;
	}
	return {
		name: end.name,
		area: end.area,
		c: pos.c,
		wx: round(pos.wx, 1),
		wy: round(pos.wy, 1),
		map: end.zone,
		x: round(m.x, 2),
		y: round(m.y, 2),
		f: m.f,
		source,
	};
}

function pickStop(stops, end, frames, liveFrames, anchorInfo) {
	const cands = stops.filter((s) => inZone(frames, liveFrames, end.zone, s.c, s.wx, s.wy));
	if (!cands.length) return null;
	let ref = null;
	if (end.near) ref = frames.toWorld(end.zone, end.near[0], end.near[1]);
	else if (anchorInfo && !anchorInfo.error) ref = anchorInfo.pts[0];
	if (!ref) return cands.length === 1 ? cands[0] : null;
	return cands.reduce((best, s) => (dist2d(s, ref) < dist2d(best, ref) ? s : best));
}

// foreverTables: the Forever client's { TaxiPathNode } for `client: 'forever'`
// ships (null when unavailable: those are skipped with `foreverError`).
function buildTransports({ tables, foreverTables = null, foreverBuild = null, foreverError = 'not loaded', frames, npcs, objects, liveFrames = new Map() }) {
	const warnings = [];
	const indexes = { npcs: indexByName(npcs), objects: indexByName(objects) };
	const points = { era: pathPoints(tables.TaxiPathNode), forever: foreverTables ? pathPoints(foreverTables.TaxiPathNode) : null };
	const triggers = new Map(tables.AreaTrigger.map((r) => [num(r.ID), { c: num(r.ContinentID), wx: num(r.Pos_0), wy: num(r.Pos_1), z: num(r.Pos_2) || 0 }]));
	const out = [];

	for (const t of TRANSPORTS) {
		let a;
		let b;
		let ab;
		let ba;
		let waitA;
		let waitB;
		let source;
		let ends = null; // the ends' TaxiPathNode stops (boats and zeppelins), for the timetable
		if (t.kind === 'tram') {
			const ta = triggers.get(t.a.trigger);
			const tb = triggers.get(t.b.trigger);
			const ia = triggers.get(t.inside[0]);
			const ib = triggers.get(t.inside[1]);
			if (!ta || !tb || !ia || !ib) {
				warnings.push(`${t.id}: AreaTrigger ${[t.a.trigger, t.b.trigger, ...t.inside].join('/')} missing, skipped`);
				continue;
			}
			a = endpoint(t.a, frames, liveFrames, ta, null, warnings, t.id);
			b = endpoint(t.b, frames, liveFrames, tb, null, warnings, t.id);
			if (a) a.source = `AreaTrigger ${t.a.trigger}`;
			if (b) b.source = `AreaTrigger ${t.b.trigger}`;
			const inside = Math.hypot(ib.wx - ia.wx, ib.wy - ia.wy);
			ab = ba = inside / TRANSPORT_SPEED + 2 * LOAD_SECONDS;
			waitA = waitB = TRAM_WAIT;
			source = `AreaTrigger ${t.inside.join('-')} (${Math.round(inside)} yd inside the tram), speed ${TRANSPORT_SPEED} yd/s, ${TRAM_WAIT} s wait (estimates)`;
		} else {
			const client = t.client || 'era';
			if (!points[client]) {
				warnings.push(`${t.id}: no WoW Forever client tables (${foreverError}), skipped`);
				continue;
			}
			const pathLabel = client === 'forever' ? `TaxiPath ${t.path} (WoW Forever client ${foreverBuild})` : `TaxiPath ${t.path}`;
			const pts = points[client].get(t.path);
			if (!pts || pts.length < 2) {
				warnings.push(`${t.id}: ${pathLabel} has no points, skipped`);
				continue;
			}
			const stops = stopsOf(pts);
			const anchorA = t.a.anchor ? findAnchor(t.a.anchor, indexes, frames, liveFrames, t.a.zone) : null;
			const anchorB = t.b.anchor ? findAnchor(t.b.anchor, indexes, frames, liveFrames, t.b.zone) : null;
			const sa = pickStop(stops, t.a, frames, liveFrames, anchorA);
			const sb = pickStop(stops, t.b, frames, liveFrames, anchorB);
			if (!sa || !sb || sa === sb) {
				warnings.push(`${t.id}: ${pathLabel} has no distinct stops in ${t.a.name} and ${t.b.name}, skipped`);
				continue;
			}
			a = endpoint(t.a, frames, liveFrames, sa, anchorA, warnings, t.id);
			ends = { a: { c: sa.c, wx: sa.wx, wy: sa.wy }, b: { c: sb.c, wx: sb.wx, wy: sb.wy } };
			b = endpoint(t.b, frames, liveFrames, sb, anchorB, warnings, t.id);
			const fwd = sailBetween(pts, stops, sa, sb);
			const back = sailBetween(pts, stops, sb, sa);
			const docked = stops.reduce((s, stop) => s + stop.delay, 0);
			const sailing = (leg) => leg.yards / TRANSPORT_SPEED + leg.teleports * LOAD_SECONDS;
			const cycle = sailing(fwd) + sailing(back) + docked;
			ab = sailing(fwd) + fwd.docked;
			ba = sailing(back) + back.docked;
			waitA = waitB = cycle / 2;
			const calls = fwd.docked || back.docked ? `, ${fwd.docked} s / ${back.docked} s docked at stops on the way` : '';
			source = `${pathLabel}: ${Math.round(fwd.yards)} yd / ${Math.round(back.yards)} yd between stops${calls}, ${docked} s docked per loop, speed ${TRANSPORT_SPEED} yd/s (estimate)`;
		}
		if (!a || !b) {
			warnings.push(`${t.id}: an end could not be placed, skipped`);
			continue;
		}
		out.push({
			id: t.id,
			kind: t.kind,
			faction: t.faction,
			a,
			b,
			ab: Math.round(ab),
			ba: Math.round(ba),
			waitA: Math.round(waitA),
			waitB: Math.round(waitB),
			source,
			...(ends ? { path: t.path, client: t.client || 'era', stops: ends } : {}),
		});
	}
	return { transports: out, warnings };
}

module.exports = { buildTransports, inZone, TRANSPORTS, TRANSPORT_SPEED, LOAD_SECONDS, ANCHOR_YARDS };
