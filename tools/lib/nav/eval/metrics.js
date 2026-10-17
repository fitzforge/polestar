'use strict';
// `nav eval`'s per-route metrics: one routed result (run.js) measured on its
// drawn line against our grid and the ground layers.
//
//   metrics(result, { grid, layers, map }) -> null when not ok, else
//     { yards, seconds, blocked, offRoad, hubYards: { Alliance, Horde }, hubYardsAway: { Alliance, Horde },
//       endHubs: { Alliance: [name], Horde: [name] }, maxClimbDeg, indoorYards, endIndoor, zoneYards, swumYards }
//   loadLayers(dir = data/local/nav-layers, { indoorGrid, city }) -> { roads, hubs, indoor } (each null when not built)
//   indoorLayer(grid, city?) -> indoor(c, x, y, z): true | false | null (no surface there)
//   measureIndoor(report, layers) -> report with indoorYards and endIndoor measured again on layers.indoor
//
// yards: the router's own (job.yards) when it gives them, else the drawn
// line's length (flat); seconds: cost / 7 (cost is in running yards, 7 yd/s).
// blocked: the share of the drawn line our grid (an openNav, path.js) cannot
// walk straight, measured as 0.2.4's maps were (NavPack's eval): <= 8 yd
// pieces, nav.los between consecutive piece ends; null without a grid.
// maxClimbDeg: the steepest uphill between consecutive points (degrees;
// points under 1 yd apart on the ground, a lift's rise, are skipped).
// offRoad: the share of the drawn line (by its SAMPLE yd pieces) with no road
// column within NEAR_ROAD yd (painted roads are 8-15 yd wide and wander, so
// a player that close to a road column is on the road; the drawn line is straightened over 4.17 yd cells); a road column
// has road weight ROAD or more (roads layer,
// data/local/nav-layers/roads/<c>/<col>_<row>.bin, one byte per grid column,
// index j * 256 + i); hubYards: per side, the yards a
// player of that side walks inside hubs hostile to it (hubYards.Horde: yards
// in Alliance hubs; hubs.json, per continent [{ id, side (the owner), name,
// disks: [[x, y, r]] }]); hubYardsAway: the same without the hubs an end
// of the line lies in (endHubs, per side the names of those hubs hostile to
// it: a route to a town of the other side enters it on purpose); indoorYards: yards on indoor ground
// (layers.indoor(c, x, y, z) -> bool, indoorLayer); endIndoor: an end of the line lies on indoor ground (a route
// that goes inside on purpose). Each null until its layer exists. zoneYards: the drawn line's yards per zone
// ({ [uiMapID]: yd }, the harness's zones: the router's own Path.ZoneAt), null on maps without zones. swumYards: the
// drawn yards over water (the harness's wet: the router's points.wet), null when the result carries none.

const fs = require('node:fs');
const path = require('node:path');
const { ROOT } = require('../../paths');
const { cellOf, tileKey, TILE_CELLS, CELL, FLAG } = require('../grid/format');

const LAYERS = path.join(ROOT, 'data', 'local', 'nav-layers');
const RUN = 7; // yd/s: a cost in running yards over seconds
const PIECE = 8; // yd: blocked-share pieces (0.2.4's eval)
const SAMPLE = 2; // yd: layer samples along the line
const ROAD = 128; // road weight from which a column is road (half the alpha)
const NEAR_ROAD = 8; // yd: a line piece this close to a road column is on the road
// Offsets (yd) of the columns around a point within NEAR_ROAD.
const AROUND = [];
for (let dx = -Math.ceil(NEAR_ROAD / CELL); dx <= Math.ceil(NEAR_ROAD / CELL); dx++) {
	for (let dy = -Math.ceil(NEAR_ROAD / CELL); dy <= Math.ceil(NEAR_ROAD / CELL); dy++) if (Math.hypot(dx, dy) * CELL <= NEAR_ROAD) AROUND.push([dx * CELL, dy * CELL]);
}
const HOSTILE_TO = { Alliance: 'Horde', Horde: 'Alliance' }; // a hub's owner -> the side it is hostile to

const flat = (a, b) => Math.hypot(b[0] - a[0], b[1] - a[1]);

function lineLength(pts) {
	let L = 0;
	for (let i = 1; i < pts.length; i++) L += flat(pts[i - 1], pts[i]);
	return L;
}

// Share (by length) of the line our grid says one cannot walk straight along. Each vertex snaps at its own height;
// piece ends between vertices at the previous end's height (following the surface, never a hill's chord).
function blockedShare(grid, c, pts) {
	let bad = 0;
	let tot = 0;
	for (let i = 1; i < pts.length; i++) {
		const [ax, ay, az] = pts[i - 1];
		const [bx, by, bz] = pts[i];
		const L = Math.hypot(bx - ax, by - ay);
		const n = Math.max(1, Math.ceil(L / PIECE));
		let prev = grid.snap({ c, wx: ax, wy: ay, z: az, radius: 6 });
		for (let k = 1; k <= n; k++) {
			const t = k / n;
			const z = k === n || !prev ? (az === null || bz === null ? null : az + (bz - az) * t) : prev.z;
			const s = grid.snap({ c, wx: ax + (bx - ax) * t, wy: ay + (by - ay) * t, z, radius: 6 });
			tot += L / n;
			if (!prev || !s || !grid.los(prev, s)) bad += L / n;
			prev = s;
		}
	}
	return tot ? bad / tot : 0;
}

// Walk the line in <= SAMPLE yd pieces; fn(x, y, z, length) per piece midpoint.
function along(pts, fn) {
	for (let i = 1; i < pts.length; i++) {
		const [ax, ay, az] = pts[i - 1];
		const [bx, by, bz] = pts[i];
		const L = Math.hypot(bx - ax, by - ay);
		const n = Math.max(1, Math.ceil(L / SAMPLE));
		for (let k = 0; k < n; k++) {
			const t = (k + 0.5) / n;
			fn(ax + (bx - ax) * t, ay + (by - ay) * t, az === null || bz === null ? null : az + (bz - az) * t, L / n);
		}
	}
}

function maxClimb(pts) {
	let best = 0;
	for (let i = 1; i < pts.length; i++) {
		const d = flat(pts[i - 1], pts[i]);
		const dz = pts[i][2] - pts[i - 1][2];
		if (d < 1 || pts[i][2] === null || pts[i - 1][2] === null || !(dz > 0)) continue;
		best = Math.max(best, (Math.atan2(dz, d) * 180) / Math.PI);
	}
	return +best.toFixed(2);
}

function metrics(result, { grid = null, layers = {}, map = result.map } = {}) {
	if (!result || !result.ok) return null;
	const pts = result.pts || [];
	const drawn = lineLength(pts);
	let offRoad = null;
	if (layers.roads) {
		let off = 0;
		let known = 0;
		along(pts, (x, y, z, L) => {
			if (layers.roads(map, x, y) === null) return;
			known += L;
			if (!AROUND.some(([dx, dy]) => (layers.roads(map, x + dx, y + dy) || 0) >= ROAD)) off += L;
		});
		offRoad = known ? off / known : null;
	}
	let hubYards = null;
	let hubYardsAway = null;
	let endHubs = null;
	if (layers.hubs) {
		hubYards = { Alliance: 0, Horde: 0 };
		hubYardsAway = { Alliance: 0, Horde: 0 };
		endHubs = { Alliance: [], Horde: [] };
		const hubs = layers.hubs[map] || layers.hubs[String(map)] || [];
		const holds = (h, x, y) => h.disks.some(([hx, hy, r]) => Math.hypot(x - hx, y - hy) <= r);
		// The hubs an end of the line lies in, by the side they are hostile to.
		const atEnd = new Set();
		for (const p of pts.length ? [pts[0], pts[pts.length - 1]] : []) {
			for (const h of hubs) {
				if (!HOSTILE_TO[h.side] || atEnd.has(h) || !holds(h, p[0], p[1])) continue;
				atEnd.add(h);
				endHubs[HOSTILE_TO[h.side]].push(h.name);
			}
		}
		// A hub's side is its owner; its yards count for the other side (a Horde player in an Alliance hub).
		along(pts, (x, y, z, L) => {
			const inside = new Set();
			const away = new Set();
			for (const h of hubs) {
				const hostileTo = HOSTILE_TO[h.side];
				if (!hostileTo || (inside.has(hostileTo) && away.has(hostileTo)) || !holds(h, x, y)) continue;
				inside.add(hostileTo);
				if (!atEnd.has(h)) away.add(hostileTo);
			}
			for (const side of inside) hubYards[side] += L;
			for (const side of away) hubYardsAway[side] += L;
		});
		for (const side of Object.keys(hubYards)) {
			hubYards[side] = +hubYards[side].toFixed(1);
			hubYardsAway[side] = +hubYardsAway[side].toFixed(1);
		}
	}
	let indoorYards = null;
	let endIndoor = null;
	if (layers.indoor) {
		indoorYards = 0;
		along(pts, (x, y, z, L) => {
			if (layers.indoor(map, x, y, z)) indoorYards += L;
		});
		indoorYards = +indoorYards.toFixed(1);
		endIndoor = (pts.length ? [pts[0], pts[pts.length - 1]] : []).some((p) => !!layers.indoor(map, p[0], p[1], p[2]));
	}
	return {
		yards: +(typeof result.yards === 'number' ? result.yards : drawn).toFixed(1),
		seconds: typeof result.cost === 'number' ? +(result.cost / RUN).toFixed(1) : null,
		blocked: grid && grid.available !== false ? +blockedShare(grid, map, pts).toFixed(4) : null,
		offRoad: offRoad === null ? null : +offRoad.toFixed(4),
		hubYards,
		hubYardsAway,
		endHubs,
		maxClimbDeg: maxClimb(pts),
		indoorYards,
		endIndoor,
		zoneYards: result.zones ? { ...result.zones } : null,
		swumYards: typeof result.wet === 'number' ? +result.wet.toFixed(1) : null,
	};
}

// The indoor layer from a grid (an openNav: tile(c, col, row) -> { first, z, flags, areas }), as the packer's indoor
// class (pack.js nodeClass): a point is indoors when its column's walkable surface nearest its height (the highest
// without one) is FLAG.INDOOR, unless its chunk lies in a capital (city(c, x, y, areaId), pack.js cityTest: a
// capital's interiors are its streets, the indoor city class, no building cut through). null where the column holds
// no walkable surface.
function indoorLayer(grid, city = () => false) {
	return (c, x, y, z) => {
		const { col, row, i, j } = cellOf(x, y);
		const t = grid.tile(c, col, row);
		if (!t) return null;
		const k = j * TILE_CELLS + i;
		let best = -1;
		let bestDz = Infinity;
		for (let e = t.first[k]; e < t.first[k + 1]; e++) {
			if (t.flags[e] & FLAG.BLOCKED) continue;
			const dz = z === null || z === undefined ? -t.z[e] : Math.abs(t.z[e] - z);
			if (dz < bestDz) {
				best = e;
				bestDz = dz;
			}
		}
		if (best < 0) return null;
		if (!(t.flags[best] & FLAG.INDOOR)) return false;
		return !city(c, x, y, t.areas ? t.areas[(j >> 4) * 16 + (i >> 4)] : 0);
	};
}

// The ground layers under data/local/nav-layers, null where not built yet; indoor from indoorGrid (an openNav of
// the current grid) when given, capitals by city (indoorLayer).
function loadLayers(dir = LAYERS, { indoorGrid = null, city } = {}) {
	const roadsDir = path.join(dir, 'roads');
	let roads = null;
	if (fs.existsSync(roadsDir)) {
		const tiles = new Map();
		roads = (c, wx, wy) => {
			const { col, row, i, j } = cellOf(wx, wy);
			const key = `${c}/${tileKey(col, row)}`;
			if (!tiles.has(key)) {
				const file = path.join(roadsDir, String(c), `${tileKey(col, row)}.bin`);
				tiles.set(key, fs.existsSync(file) ? fs.readFileSync(file) : null);
			}
			const t = tiles.get(key);
			return t ? t[j * TILE_CELLS + i] : null;
		};
	}
	const hubsFile = path.join(dir, 'hubs.json');
	const hubs = fs.existsSync(hubsFile) ? JSON.parse(fs.readFileSync(hubsFile, 'utf8')) : null;
	return { roads, hubs, indoor: indoorGrid ? indoorLayer(indoorGrid, city) : null };
}

// A report read back (an earlier --out, e.g. a baseline measured before the indoor layer existed): each found route's
// indoorYards and endIndoor measured again on layers.indoor, its other metrics kept. Changes report in place.
function measureIndoor(report, layers) {
	if (!layers.indoor) return report;
	for (const r of report.routes || []) {
		if (!r.result.ok || !r.metrics) continue;
		const m = metrics(r.result, { layers: { indoor: layers.indoor }, map: r.map });
		r.metrics.indoorYards = m.indoorYards;
		r.metrics.endIndoor = m.endIndoor;
	}
	return report;
}

module.exports = { metrics, loadLayers, indoorLayer, measureIndoor, lineLength, blockedShare, maxClimb };
