'use strict';
// Walking paths players reported as impossible, each on the real engine and
// the shipped maps (addon/Polestar_Nav): the player's spot and the target as
// the bug report gave them (Era map coordinates), the path the engine draws,
// and the ground it must not cross. A report stays here once fixed, so the
// next re-pack cannot bring it back.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { needs, DATA } = require('./helpers/data');

const skip = needs('map-frames.json');

// Compat.MapToWorld with the Era frame: continent, wx (north), wy (west).
function world(map, x, y) {
	const b = JSON.parse(fs.readFileSync(path.join(DATA, 'map-frames.json'), 'utf8')).era[map];
	return { c: b.c, x: b.top + ((b.bottom - b.top) * y) / 100, y: b.left + ((b.right - b.left) * x) / 100 };
}

// The engine's path from `from` to `to` (no heights: the client reports none),
// as { points = { { x, y, z }, ... }, cost } or false when it finds none;
// profile: "Alliance" | "Horde" (none by default).
function walk(from, to, profile) {
	assert.equal(from.c, to.c);
	const [got] = runAddon({
		stubs: ['stub_encoding.lua'],
		addons: ['Polestar_Nav'],
		script: `
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local got = false
Path.Find(${from.c}, { x = ${from.x}, y = ${from.y} }, { x = ${to.x}, y = ${to.y} }, function(points, cost)
	if points then
		got = { points = {}, cost = cost }
		for i, p in ipairs(points) do got.points[i] = { p.x, p.y, p.z or false } end
	end
end${profile ? `, { profile = "${profile}" }` : ''})
while #frames > 0 do table.remove(frames, 1)() end
emit(got)`,
	}).emitted;
	return got;
}

// Nearest distance (yd) from point p to the path's line.
function offPath(points, p) {
	let best = Infinity;
	for (let i = 1; i < points.length; i++) {
		const [ax, ay] = points[i - 1];
		const [bx, by] = points[i];
		const dx = bx - ax;
		const dy = by - ay;
		const l2 = dx * dx + dy * dy;
		const t = l2 > 0 ? Math.max(0, Math.min(1, ((p.x - ax) * dx + (p.y - ay) * dy) / l2)) : 0;
		best = Math.min(best, Math.hypot(ax + dx * t - p.x, ay + dy * t - p.y));
	}
	return best;
}

// Fitz, 2026-10-16, Raptor Horns (The Barrens): from 61.66,35.46 to the
// horns' first spot at 61.00,33.70 the arrow went straight up the hill in
// front of him, which he could not climb. The maps put the ground at 80 yd
// where he stood and 94 yd 12 yd on (84, 90 between: 45-56 degrees), flat
// beyond; every cell of that face packed as walkable both ways.
test('Raptor Horns, the Barrens: the walk from 61.66,35.46 to 61.00,33.70 does not climb the 80 to 94 yd face in front of the player', { skip }, () => {
	const from = world(1413, 61.66, 35.46);
	const to = world(1413, 61.0, 33.7);
	const got = walk(from, to);
	assert.ok(got, 'the engine finds a walk');
	const pts = got.points;
	const last = pts[pts.length - 1];
	assert.ok(Math.hypot(last[0] - to.x, last[1] - to.y) < 10, 'to the spot');
	// The middle of the face: 8 yd from the player towards the spot (90 yd high).
	const straight = Math.hypot(to.x - from.x, to.y - from.y);
	const face = { x: from.x + ((to.x - from.x) * 8) / straight, y: from.y + ((to.y - from.y) * 8) / straight };
	const off = offPath(pts, face);
	assert.ok(off > 3, `the path passes ${off.toFixed(1)} yd from the face's middle (${pts.length} points, ${Math.round(got.cost)} yd)`);
});

// Fitz, 2026-10-16, Ratchet (The Barrens), Horde, heading for 54,51: the walk
// left the north-east road, ran straight south along a line and turned 90
// degrees west onto the main road instead of keeping to the north-east road
// down to the junction. The tile border at y -3733.3 crosses both roads 35 yd
// apart, and its one entrance there sat on the main road, so every walk off
// the north-east road crossed the border along it. The 62 yd leg between two
// spots on the north-east road either side of the border walked 91 yd.
test('Ratchet, the Barrens: the 62 yd walk along the north-east road across the tile border (-913.3,-3749.2 to -935.1,-3692) stays on the road', { skip }, () => {
	const from = { c: 1, x: -913.3, y: -3749.2 };
	const to = { c: 1, x: -935.1, y: -3692 };
	const got = walk(from, to, 'Horde');
	assert.ok(got, 'the engine finds a walk');
	const pts = got.points;
	const last = pts[pts.length - 1];
	assert.ok(Math.hypot(last[0] - to.x, last[1] - to.y) < 10, 'to the spot');
	let yards = 0;
	for (let i = 1; i < pts.length; i++) yards += Math.hypot(pts[i][0] - pts[i - 1][0], pts[i][1] - pts[i - 1][1]);
	const straight = Math.hypot(to.x - from.x, to.y - from.y);
	assert.ok(yards <= straight * 1.15, `the walk is ${yards.toFixed(1)} yd for ${straight.toFixed(1)} yd straight (${pts.length} points)`);
});
