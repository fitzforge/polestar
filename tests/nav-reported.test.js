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
// as { points = { { x, y, z }, ... }, cost } or false when it finds none.
function walk(from, to) {
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
end)
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
