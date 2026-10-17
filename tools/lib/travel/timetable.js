'use strict';
// Timetables for boats, zeppelins, the Deeprun Tram and lifts, the walk-in
// portals and the class teleports: the data addon/Polestar/Nav/Transit.lua
// reads (`ns.Transit.Register`) and the planner's ride costs.
//
// Ported from Shortest Path Forever (GPL-3.0-or-later, by Cillian Berragan,
// used with permission): tools/gen_routes.py (the boat model) and
// tools/gen_transit.py (lifts, tram, portals, teleports).
// Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
// Portions Copyright (C) the CMaNGOS project (see its AUTHORS file), GPL-2.0-or-later, used under GPL-3.0.
//
// Boats and zeppelins run the server's own transport model: CMaNGOS
// mangos-classic TransportMgr::GenerateWaypoints (Catmull-Rom spline lengths,
// three samples per segment, 30 yd/s cruising with 1 yd/s^2 acceleration and
// braking, each stop's TaxiPathNode Delay docked), over the client's
// TaxiPathNode loop. The model runs ~0.05% fast against the periods CMaNGOS
// classic-db sniffed from the original servers, so each route is stretched
// onto its sniffed period (the mean correction where none was sniffed).
//
// Lifts and the tram run the client's TransportAnimation track (time index,
// offset from the spawn; Y reversed, as CMaNGOS ElevatorTransport::Update),
// placed at their classic-db gameobject spawns.
//
// A loop's phase is (server ms - epoch) % period; the epoch is the server's
// uptime and so unknowable here: Transit.lua learns it from rides it watches
// (Shortest Path Forever's observer). Until then a ride costs its expected
// wait: the mean, over a uniform phase, of the time to the next departure.
//
// Times are integer milliseconds in the routes (as the source models them)
// and seconds in the services' expected waits and rides.

const { round, dist2d } = require('./geo');
const { inZone } = require('./transports');

const SPEED = 30;
const ACCEL = 1;
const STOP = 2;
const TELEPORT = 1;
// CMaNGOS classic-db 22b5146 `transports.period` (ms), sniffed from the original servers.
const REFERENCE_PERIODS = { 241: 350818, 285: 303463, 292: 329313, 293: 316251, 295: 295579, 301: 333044, 302: 356284, 303: 317038 };
const PERIOD_TOLERANCE = 0.005;
const SAME_DOCK = 30;     // yards: a loop's stops this close are one dock
const DOCK_MATCH = 60;    // yards: a transport end's TaxiPathNode stop matches a keyframe stop
const LOAD_SECONDS = 10;  // a loading screen (the tram's way in and out)
const TRAM_WALK = 5;      // seconds from the tram's arrival point to its platform
// Seconds before a departure the player must be at the dock to make it.
const BOARD = { boat: 10, zeppelin: 10, tram: 5, lift: 2 };
// Observer fit thresholds (Shortest Path Forever's): samples, span ms, min speed yd/s.
const FIT = {
	boat: { samples: 10, span: 30000, speed: 12 },
	tram: { samples: 10, span: 30000, speed: 12 },
	lift: { samples: 5, span: 4000, speed: 8 },
	liftSlow: { samples: 5, span: 4000, speed: 6 },
	liftShort: { samples: 3, span: 2000, speed: 8 },
};
const STEP = 0.05; // seconds: the expected-wait integral's step

const CATMULL_ROM = [
	[-0.5, 1.5, -1.5, 0.5],
	[1.0, -2.5, 2.0, -0.5],
	[-0.5, 0.0, 0.5, 0.0],
	[0.0, 1.0, 0.0, 0.0],
];

const int = (v) => Number.parseInt(v, 10) || 0;
const dist3 = (a, b) => Math.hypot(a[0] - b[0], a[1] - b[1], a[2] - b[2]);
const mod = (a, n) => ((a % n) + n) % n;

// --- the boat model (CMaNGOS TransportMgr::GenerateWaypoints) ---------------

function evaluate(points, t) {
	const powers = [t * t * t, t * t, t, 1];
	const w = [0, 1, 2, 3].map((c) => powers.reduce((s, p, r) => s + p * CATMULL_ROM[r][c], 0));
	return [0, 1, 2].map((d) => w.reduce((s, wk, k) => s + wk * points[k][d], 0));
}

// Length of each spline segment between consecutive controls, as the server measures it.
function segmentLengths(controls) {
	if (controls.length < 2) return [];
	const first = controls[0].map((a, d) => 2 * a - controls[1][d]);
	const points = [first, ...controls, controls[controls.length - 1]];
	const lengths = [];
	for (let i = 1; i < controls.length; i++) {
		const window = points.slice(i - 1, i + 3);
		let previous = controls[i - 1];
		let length = 0;
		for (const step of [1, 2, 3]) {
			const current = evaluate(window, step / 3);
			length += dist3(current, previous);
			previous = current;
		}
		lengths.push(length);
	}
	return lengths;
}

// The server's keyframes: interior nodes, each teleport marked on the frame before it.
function keyframes(nodes) {
	const frames = [];
	let skip = false;
	for (let i = 1; i < nodes.length - 1; i++) {
		if (skip) {
			skip = false;
			continue;
		}
		const n = nodes[i];
		if (int(n.Flags) & TELEPORT || int(n.ContinentID) !== int(nodes[i + 1].ContinentID)) {
			if (frames.length) frames[frames.length - 1].teleport = true;
			skip = true;
			continue;
		}
		frames.push({ c: int(n.ContinentID), pos: [Number(n.Loc_0), Number(n.Loc_1), Number(n.Loc_2)], stop: int(n.Flags) === STOP, delay: Number(n.Delay) || 0, teleport: false, dist: 0 });
	}
	if (frames.length) frames[frames.length - 1].teleport = true;
	let start = 0;
	for (let i = 1; i < frames.length; i++) {
		if (frames[i - 1].teleport || i + 1 === frames.length) {
			const end = i + (frames[i - 1].teleport ? 0 : 1);
			segmentLengths(frames.slice(start, end).map((f) => f.pos)).forEach((length, k) => {
				frames[start + 1 + k].dist = length;
			});
			start = i;
		}
	}
	return frames;
}

// Seconds from a frame to the next stop, `since` yards past the last stop and `until` before the next.
function moveTime(since, until) {
	const accelDist = (0.5 * SPEED * SPEED) / ACCEL;
	if (since + until < 2 * accelDist) {
		if (since < until) return 2 * Math.sqrt((since + until) / ACCEL) - Math.sqrt((2 * since) / ACCEL);
		return Math.sqrt((2 * until) / ACCEL);
	}
	if (since < accelDist) return (since + until) / SPEED + SPEED / ACCEL - Math.sqrt((2 * since) / ACCEL);
	if (until < accelDist) return Math.sqrt((2 * until) / ACCEL);
	return until / SPEED + (0.5 * SPEED) / ACCEL;
}

// TaxiPathNode rows of one loop (NodeIndex order) -> { frames (with arrive/depart seconds), period seconds }.
// A loop too short to model -> null.
function boatTimetable(nodes) {
	const frames = keyframes(nodes);
	const count = frames.length;
	if (count < 2) return null;
	const stops = frames.map((f, i) => (f.stop ? i : -1)).filter((i) => i >= 0);
	const first = stops.length ? stops[0] : 0;
	const last = stops.length ? stops[stops.length - 1] : 0;
	let distance = 0;
	for (let k = 0; k < count; k++) {
		const j = (k + last) % count;
		distance = frames[j].stop || j === last ? 0 : distance + frames[j].dist;
		frames[j].since = distance;
	}
	distance = 0;
	for (let k = count - 1; k >= 0; k--) {
		const j = (k + first) % count;
		distance += frames[(j + 1) % count].dist;
		frames[j].until = distance;
		if (frames[j].stop || j === first) distance = 0;
	}
	for (const f of frames) f.to = moveTime(f.since, f.until);
	let clock = frames[0].stop ? frames[0].delay : 0;
	frames[0].arrive = 0;
	frames[0].depart = clock;
	for (let i = 1; i < count; i++) {
		clock += frames[i - 1].to;
		if (frames[i].stop) {
			frames[i].arrive = clock;
			clock += frames[i].delay;
			frames[i].depart = clock;
		} else {
			clock -= frames[i].to;
			frames[i].arrive = frames[i].depart = clock;
		}
	}
	return { frames, period: clock };
}

// --- expected waits ----------------------------------------------------------

// Departure gaps (seconds) of one route at one side: the times between its
// consecutive departures from those stops around the loop.
function gapsOf(route, idx) {
	const period = route.period / 1000;
	const departs = [...new Set(idx.map((i) => mod(route.stops[i][1] / 1000, period)))].sort((a, b) => a - b);
	return departs.map((d, k) => (k + 1 < departs.length ? departs[k + 1] - d : departs[0] + period - d));
}

// Expected seconds from reaching the dock to the next departure one can
// board, over independent uniform phases of the service's routes:
// board + integral of prod_r P(wait_r > t) dt.
function expectedWait(parts, board) {
	const gaps = parts.map(({ route, idx }) => ({ gaps: gapsOf(route, idx), period: route.period / 1000 }));
	const longest = Math.min(...gaps.map((g) => Math.max(...g.gaps)));
	let total = 0;
	for (let t = STEP / 2; t < longest; t += STEP) {
		let survive = 1;
		for (const g of gaps) survive *= g.gaps.reduce((s, gap) => s + Math.max(0, gap - t), 0) / g.period;
		total += survive * STEP;
	}
	return board + total;
}

// Seconds riding from stop i to the next arrival at any of `to`.
function rideFrom(route, i, to) {
	let best = Infinity;
	for (const j of to) {
		const ride = mod(route.stops[j][0] - route.stops[i][1], route.period);
		if (ride < best) best = ride;
	}
	return best / 1000;
}

// Gap-weighted mean ride from a side to the other: a departure after a long
// gap is the one most arrivals catch.
function expectedRide(parts, from, to) {
	let sum = 0;
	let weight = 0;
	for (const part of parts) {
		const period = part.route.period;
		const departs = part[from].map((i) => ({ i, d: mod(part.route.stops[i][1], period) })).sort((a, b) => a.d - b.d);
		departs.forEach(({ i, d }, k) => {
			const prev = k > 0 ? departs[k - 1].d : departs[departs.length - 1].d - period;
			const gap = (d - prev || period) / period;
			sum += gap * rideFrom(part.route, i, part[to]);
			weight += gap;
		});
	}
	return sum / weight;
}

function serviceTimes(service, routes) {
	const parts = service.routes.map((p) => ({ ...p, route: routes[p.route] }));
	const side = (from, to) => ({
		wait: round(service.pre + expectedWait(parts.map((p) => ({ route: p.route, idx: p[from] })), service.board), 1),
		ride: round(expectedRide(parts, from, to) + service.post, 1),
	});
	const a = side('a', 'b');
	const b = side('b', 'a');
	return { wait: { a: a.wait, b: b.wait }, ride: { a: a.ride, b: b.ride } };
}

// --- boats and zeppelins -----------------------------------------------------

function pathNodes(rows) {
	const byPath = new Map();
	for (const r of rows || []) {
		const id = int(r.PathID);
		if (!byPath.has(id)) byPath.set(id, []);
		byPath.get(id).push(r);
	}
	for (const list of byPath.values()) list.sort((a, b) => int(a.NodeIndex) - int(b.NodeIndex));
	return byPath;
}

// One loop -> route { kind, period, stops: [[arrive, depart, c, wx, wy]], frames: [[arrive, depart, c, wx, wy, jump]] }.
// -> { route } or { error } (too short to model, or a sniffed period the model misses).
function boatRoute(nodes, path, kind, meanRatio) {
	const model = boatTimetable(nodes);
	if (!model) return { error: 'too short to time' };
	const { frames, period } = model;
	const reference = REFERENCE_PERIODS[path];
	if (reference && Math.abs(period * 1000 - reference) / reference > PERIOD_TOLERANCE) {
		return { error: `modelled period ${Math.round(period * 1000)} ms is not the sniffed ${reference} ms` };
	}
	const scale = reference ? reference / (period * 1000) : meanRatio;
	const ms = (s) => Math.round(s * 1000 * scale);
	const stops = [];
	for (const f of frames) {
		if (!f.stop) continue;
		stops.push([ms(f.arrive), ms(f.depart), f.c, round(f.pos[0], 1), round(f.pos[1], 1)]);
	}
	// A stop split by the loop's start (arrive at the end, leave at the beginning) is one visit.
	const head = stops[0];
	const tail = stops[stops.length - 1];
	if (stops.length > 1 && head[0] === 0 && head[2] === tail[2] && Math.hypot(head[3] - tail[3], head[4] - tail[4]) <= SAME_DOCK) {
		head[0] = stops.pop()[0];
	}
	return {
		route: {
			kind,
			period: ms(period),
			fit: FIT.boat,
			stops,
			frames: frames.map((f) => [ms(f.arrive), ms(f.depart), f.c, round(f.pos[0], 1), round(f.pos[1], 1), f.teleport ? 1 : 0]),
		},
	};
}

// The stops of a route at a transport end's TaxiPathNode stop.
function stopsAt(route, at) {
	const idx = [];
	route.stops.forEach((s, i) => {
		if (s[2] === at.c && Math.hypot(s[3] - at.wx, s[4] - at.wy) <= DOCK_MATCH) idx.push(i);
	});
	return idx;
}

// --- lifts and the tram (TransportAnimation) ---------------------------------

// Explicit site and car identities (entry, spawn guid) keep ids stable if
// the sources gain spawns. Shortest Path Forever's list. area: the AreaTable
// area the lift is named by (its name in the client's language); dir: which
// of that place's lifts ("Undercity, east lift"), none for a lift named by
// its area alone.
const LIFTS = [
	{ id: 'lift-great-lift', name: 'The Great Lift', area: 485, cars: [[11898, 16874], [11899, 16876]], fit: 'lift' },
	{ id: 'lift-freewind-post', name: 'Freewind Post', area: 484, cars: [[11898, 16875], [11899, 16877]], fit: 'lift' },
	{ id: 'lift-thunder-bluff-west', name: 'Thunder Bluff, west lift', area: 1638, dir: 'west', cars: [[4170, 18298], [4171, 18435]], fit: 'liftSlow' },
	{ id: 'lift-thunder-bluff-north', name: 'Thunder Bluff, north lift', area: 1638, dir: 'north', cars: [[47296, 20639], [47297, 20640]], fit: 'liftSlow' },
	{ id: 'lift-undercity-west', name: 'Undercity, west lift', area: 1497, dir: 'west', cars: [[20649, 44892]], fit: 'liftShort' },
	{ id: 'lift-undercity-east', name: 'Undercity, east lift', area: 1497, dir: 'east', cars: [[20652, 44962]], fit: 'liftShort' },
	{ id: 'lift-undercity-south', name: 'Undercity, south lift', area: 1497, dir: 'south', cars: [[20655, 44901]], fit: 'liftShort' },
];
// The two trains' lead cars (176081/176085 follow 176080; 176083/176084 follow 176082).
const TRAINS = [176080, 176082];
const DEEPRUN_TRAM_AREA = 2257; // AreaTable "Deeprun Tram"
const TRAM_SPLIT_Y = 1200; // tram instance (map 369): Ironforge station below, Stormwind above

function animationTracks(rows) {
	const tracks = new Map();
	for (const r of rows || []) {
		const id = int(r.TransportID);
		if (!tracks.has(id)) tracks.set(id, []);
		tracks.get(id).push([int(r.TimeIndex), [Number(r.Pos_0), Number(r.Pos_1), Number(r.Pos_2)]]);
	}
	for (const track of tracks.values()) track.sort((a, b) => a[0] - b[0]);
	return tracks;
}

// A track placed at its spawn: frames { arrive, depart, c, pos }, a held position one frame.
function worldTrack(track, spawn) {
	const frames = [];
	for (const [time, [x, y, z]] of track) {
		const pos = [spawn.x + x, spawn.y - y, spawn.z + z];
		const prev = frames[frames.length - 1];
		if (prev && dist3(prev.pos, pos) < 0.001) prev.depart = time;
		else frames.push({ arrive: time, depart: time, c: spawn.map, pos });
	}
	return frames;
}

// Landings (held frames) -> stops; a dwell straddling phase zero is joined.
function trackStops(frames, period, sideOf) {
	const stops = [];
	for (const f of frames) {
		if (f.depart <= f.arrive) continue;
		const side = sideOf(f);
		const stop = [f.arrive, f.depart, f.c, round(f.pos[0], 1), round(f.pos[1], 1), round(f.pos[2], 1), side];
		const head = stops.find((s) => s[6] === side && s[0] === 0 && s.car === f.car);
		if (f.depart === period && head) head[0] = f.arrive;
		else {
			stop.car = f.car;
			stops.push(stop);
		}
	}
	stops.sort((a, b) => a[0] - b[0] || (a[6] < b[6] ? -1 : a[6] > b[6] ? 1 : 0) || a.car - b.car);
	return stops;
}

// Stops are { arrive, depart, c, wx, wy, z, car }: car numbers the cars of
// one loop from 1 (the Great Lift's two cars share a loop but not a place).
function trackRoute(kind, fit, cars, period, sideOf) {
	const frames = [];
	cars.forEach((car, k) => {
		for (const f of car) frames.push({ ...f, car: k });
		frames[frames.length - 1].jump = true;
	});
	const stops = trackStops(frames, period, sideOf);
	return {
		route: {
			kind,
			period,
			fit: FIT[fit],
			stops: stops.map((s) => [...s.slice(0, 6), s.car + 1]),
			frames: frames.map((f) => [f.arrive, f.depart, f.c, round(f.pos[0], 1), round(f.pos[1], 1), f.jump ? 1 : 0, round(f.pos[2], 1)]),
		},
		a: stops.map((s, i) => (s[6] === 'a' ? i : -1)).filter((i) => i >= 0),
		b: stops.map((s, i) => (s[6] === 'b' ? i : -1)).filter((i) => i >= 0),
	};
}

function spawnOf(db, entry, guid) {
	const list = (db.spawns && db.spawns[entry]) || [];
	return guid ? list.find((s) => s.guid === guid) : list[0];
}

function buildLifts(tracks, db, routes, services, warnings) {
	for (const site of LIFTS) {
		const cars = [];
		for (const [entry, guid] of site.cars) {
			const spawn = spawnOf(db, entry, guid);
			const track = tracks.get(entry);
			if (!spawn || !track) {
				warnings.push(`${site.id}: ${spawn ? 'TransportAnimation' : 'classic-db spawn'} of ${entry} (${guid}) missing, skipped`);
				break;
			}
			cars.push({ entry, period: track[track.length - 1][0], frames: worldTrack(track, spawn) });
		}
		if (cars.length !== site.cars.length) continue;
		const landings = cars.flatMap((car) => car.frames.filter((f) => f.depart > f.arrive));
		const zs = landings.map((f) => f.pos[2]);
		const middle = (Math.min(...zs) + Math.max(...zs)) / 2;
		const sideOf = (f) => (f.pos[2] > middle ? 'a' : 'b');
		const mean = (list, axis) => list.reduce((s, f) => s + f.pos[axis], 0) / list.length;
		const top = landings.filter((f) => sideOf(f) === 'a');
		const bottom = landings.filter((f) => sideOf(f) === 'b');
		// Cars sharing a period share a phase (one route); Thunder Bluff's
		// pairs differ by 33 ms a cycle, so each car is its own route.
		const periods = new Set(cars.map((c) => c.period));
		const groups = periods.size > 1 ? cars.map((c) => [c]) : [cars];
		const parts = [];
		groups.forEach((group, k) => {
			const id = groups.length > 1 ? `${site.id}-${k + 1}` : site.id;
			const built = trackRoute('lift', site.fit, group.map((c) => c.frames), group[0].period, sideOf);
			routes[id] = built.route;
			parts.push({ route: id, a: built.a, b: built.b });
		});
		services[site.id] = {
			kind: 'lift',
			name: site.name,
			area: site.area,
			...(site.dir ? { dir: site.dir } : {}),
			c: landings[0].c,
			wx: round(mean(landings, 0), 1),
			wy: round(mean(landings, 1), 1),
			top: round(mean(top, 2), 1),
			bottom: round(mean(bottom, 2), 1),
			board: BOARD.lift,
			pre: 0,
			post: 0,
			routes: parts,
		};
	}
}

// The tram: the two trains between the Stormwind (a) and Ironforge (b)
// stations of the tram instance; entering and leaving cost a loading screen
// and the walk to the platform each.
function buildTram(transport, tracks, db, routes, services, warnings) {
	const parts = [];
	for (const entry of TRAINS) {
		const spawn = spawnOf(db, entry);
		const track = tracks.get(entry);
		if (!spawn || !track) {
			warnings.push(`${transport.id}: ${spawn ? 'TransportAnimation' : 'classic-db spawn'} of train ${entry} missing, skipped`);
			return;
		}
		const id = `tram-${entry}`;
		const built = trackRoute('tram', 'tram', [worldTrack(track, spawn)], track[track.length - 1][0], (f) => (f.pos[1] < TRAM_SPLIT_Y ? 'b' : 'a'));
		routes[id] = built.route;
		parts.push({ route: id, a: built.a, b: built.b });
	}
	services[transport.id] = { kind: 'tram', name: 'Deeprun Tram', area: DEEPRUN_TRAM_AREA, ends: [transport.a.name, transport.b.name], areas: [transport.a.area, transport.b.area], board: BOARD.tram, pre: LOAD_SECONDS + TRAM_WALK, post: LOAD_SECONDS + TRAM_WALK, routes: parts };
}

// --- portals and teleports ---------------------------------------------------

// Walk-in portals: the AreaTrigger (client) to its classic-db destination;
// fromArea / toArea the AreaTable areas of its ends.
const PORTALS = [
	{ trigger: 527, id: 'portal-ruttheran', from: 'Darnassus', fromArea: 1657, to: "Rut'theran Village", toArea: 702 },
	{ trigger: 542, id: 'portal-darnassus', from: "Rut'theran Village", fromArea: 702, to: 'Darnassus', toArea: 1657 },
];
const PORTAL_SECONDS = 5; // the loading screen

// Teleport effects (TELEPORT_UNITS, classic and this client's numbering) and
// the destinations used: the bind point, and spell_target_position.
const TELEPORT_EFFECTS = new Set([5, 252]);
const DEST_HOME = 9;
const DEST_DB = 17;
const HEARTHSTONE_SPELL = 8690; // the planner's own hearth leg
// The AreaTable area each class teleport's destination is named by (the
// spell's own name comes from the client: SpellName).
const TELEPORT_AREA = { 3561: 1519, 3562: 1537, 3563: 1497, 3565: 1657, 3566: 1638, 3567: 1637, 18960: 493 };

// A world point -> an end { name, area?, c, wx, wy, map, x, y, f } on the smallest
// zone or city map holding it (its live frame where Forever redrew it); area:
// the AreaTable area it is named by.
function place(name, c, wx, wy, frames, liveFrames, area) {
	for (const cand of frames.containing(c, wx, wy)) {
		const m = inZone(frames, liveFrames, cand.map, c, wx, wy);
		if (m) return { name, ...(area ? { area } : {}), c, wx: round(wx, 1), wy: round(wy, 1), map: cand.map, x: round(m.x, 2), y: round(m.y, 2), f: m.f };
	}
	return null;
}

function buildPortals(areaTriggers, db, frames, liveFrames, warnings) {
	const triggers = new Map((areaTriggers || []).map((r) => [int(r.ID), r]));
	const out = [];
	for (const p of PORTALS) {
		const t = triggers.get(p.trigger);
		const dest = db.portals && db.portals[p.trigger];
		if (!t || !dest) {
			warnings.push(`${p.id}: ${t ? 'classic-db areatrigger_teleport' : 'AreaTrigger'} ${p.trigger} missing, skipped`);
			continue;
		}
		const a = place(p.from, int(t.ContinentID), Number(t.Pos_0), Number(t.Pos_1), frames, liveFrames, p.fromArea);
		const b = place(p.to, dest.map, dest.x, dest.y, frames, liveFrames, p.toArea);
		if (!a || !b) {
			warnings.push(`${p.id}: an end is on no map, skipped`);
			continue;
		}
		out.push({ id: p.id, name: p.to, area: p.toArea, a, b, seconds: PORTAL_SECONDS, source: `AreaTrigger ${p.trigger} -> classic-db areatrigger_teleport ${p.trigger}` });
	}
	return out;
}

// Class teleports (a SkillLineAbility with a class), to their
// spell_target_position, and class spells to the bind point (Astral Recall).
function buildTeleports(tables, db, frames, liveFrames, warnings) {
	const names = new Map((tables.SpellName || []).map((r) => [int(r.ID), r.Name_lang]));
	const targets = new Map();
	for (const r of tables.SpellEffect || []) {
		const target = int(r.ImplicitTarget_1);
		if (int(r.DifficultyID) === 0 && TELEPORT_EFFECTS.has(int(r.Effect)) && (target === DEST_HOME || target === DEST_DB)) targets.set(int(r.SpellID), target);
	}
	const classSpells = new Set((tables.SkillLineAbility || []).filter((r) => int(r.ClassMask)).map((r) => int(r.Spell)));
	const castTimes = new Map((tables.SpellCastTimes || []).map((r) => [int(r.ID), int(r.Base)]));
	const castIndex = new Map((tables.SpellMisc || []).filter((r) => int(r.DifficultyID) === 0).map((r) => [int(r.SpellID), int(r.CastingTimeIndex)]));
	const reagents = new Map();
	for (const r of tables.SpellReagents || []) {
		const need = []; // item, count, item, count, ...
		for (let i = 0; i < 8; i++) if (int(r[`Reagent_${i}`]) && int(r[`ReagentCount_${i}`]) > 0) need.push(int(r[`Reagent_${i}`]), int(r[`ReagentCount_${i}`]));
		if (need.length) reagents.set(int(r.SpellID), need);
	}
	const out = [];
	for (const spell of [...targets.keys()].sort((a, b) => a - b)) {
		if (!classSpells.has(spell) || spell === HEARTHSTONE_SPELL) continue;
		const name = names.get(spell) || `spell ${spell}`;
		const entry = { spell, name, cast: round((castTimes.get(castIndex.get(spell)) || 0) / 1000, 1) };
		if (reagents.has(spell)) entry.reagents = reagents.get(spell);
		if (targets.get(spell) === DEST_HOME) {
			entry.bind = true;
		} else {
			const pos = db.positions && db.positions[spell];
			const to = pos && place(name.replace(/^[^:]*:\s*/, ''), pos.map, pos.x, pos.y, frames, liveFrames, TELEPORT_AREA[spell]);
			if (!to) {
				warnings.push(`teleport ${name} (${spell}): no destination on a mapped continent, skipped`);
				continue;
			}
			entry.to = to;
		}
		out.push(entry);
	}
	return out;
}

// --- build -------------------------------------------------------------------

// transports: buildTransports' output (each boat/zeppelin with `path`,
// `client` and its ends' TaxiPathNode `stops`); their expected ab/ba/waitA/
// waitB are replaced by the timetable's when one is built.
// -> { routes, services, portals, teleports, warnings }
function buildTimetables({ tables, foreverTables = null, transit = null, db = null, transports, frames, liveFrames = new Map() }) {
	const warnings = [];
	const routes = {};
	const services = {};
	const nodes = { era: pathNodes(tables.TaxiPathNode), forever: foreverTables ? pathNodes(foreverTables.TaxiPathNode) : null };
	// The model's steady drift against the sniffed periods.
	const ratios = [];
	for (const [path, reference] of Object.entries(REFERENCE_PERIODS)) {
		const n = nodes.era.get(Number(path));
		const model = n && n.length > 2 && boatTimetable(n);
		const ratio = model && reference / (model.period * 1000);
		if (ratio && Math.abs(ratio - 1) <= PERIOD_TOLERANCE) ratios.push(ratio);
	}
	const meanRatio = ratios.length ? ratios.reduce((s, r) => s + r, 0) / ratios.length : 1;
	const modelled = new Map(); // route id -> boatRoute's result
	for (const t of transports) {
		if (t.kind === 'tram' || !t.path) continue;
		const n = nodes[t.client || 'era'] && nodes[t.client || 'era'].get(t.path);
		if (!n || n.length < 3) continue;
		const id = `path-${t.path}`;
		if (!modelled.has(id)) modelled.set(id, boatRoute(n, t.path, t.kind, meanRatio));
		const built = modelled.get(id);
		if (built.error) {
			warnings.push(`${t.id}: TaxiPath ${t.path} ${built.error}; estimate kept`);
			continue;
		}
		routes[id] = built.route;
		const a = stopsAt(routes[id], t.stops.a);
		const b = stopsAt(routes[id], t.stops.b);
		if (!a.length || !b.length) {
			warnings.push(`${t.id}: no ${a.length ? t.b.name : t.a.name} stop on the TaxiPath ${t.path} timetable; estimate kept`);
			continue;
		}
		services[t.id] = { kind: t.kind, name: `${t.a.name} - ${t.b.name}`, ends: [t.a.name, t.b.name], areas: [t.a.area, t.b.area], board: BOARD[t.kind], pre: 0, post: 0, routes: [{ route: id, a, b }] };
	}
	let portals = [];
	let teleports = [];
	if (!transit || !db) {
		warnings.push(`lifts, tram timetable, portals and teleports skipped: ${!db ? 'no CMaNGOS classic-db' : 'no client TransportAnimation/spell tables'}`);
	} else {
		const tracks = animationTracks(transit.TransportAnimation);
		buildLifts(tracks, db, routes, services, warnings);
		const tram = transports.find((t) => t.kind === 'tram');
		if (tram) buildTram(tram, tracks, db, routes, services, warnings);
		portals = buildPortals(tables.AreaTrigger, db, frames, liveFrames, warnings);
		teleports = buildTeleports(transit, db, frames, liveFrames, warnings);
	}
	for (const [id, service] of Object.entries(services)) Object.assign(service, serviceTimes(service, routes));
	for (const t of transports) {
		const s = services[t.id];
		if (!s) continue;
		t.waitA = Math.round(s.wait.a);
		t.waitB = Math.round(s.wait.b);
		t.ab = Math.round(s.ride.a);
		t.ba = Math.round(s.ride.b);
		t.source = `${t.source}; timetable: ${s.routes.map((p) => p.route).join(', ')} (CMaNGOS transport model, sniffed periods)`;
	}
	const sortedRoutes = {};
	for (const id of Object.keys(routes).sort()) sortedRoutes[id] = routes[id];
	const sortedServices = {};
	for (const id of Object.keys(services).sort()) sortedServices[id] = services[id];
	return { routes: sortedRoutes, services: sortedServices, portals, teleports, warnings };
}

module.exports = {
	buildTimetables,
	boatTimetable,
	keyframes,
	moveTime,
	segmentLengths,
	expectedWait,
	expectedRide,
	worldTrack,
	REFERENCE_PERIODS,
	LIFTS,
	PORTALS,
	BOARD,
};
