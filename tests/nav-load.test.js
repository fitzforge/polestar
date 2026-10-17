'use strict';
// Polestar_Nav's maps are used whole or not at all (addon/Polestar_Nav/API.lua):
// a map whose part file is missing from the folder (or failed to load) is
// dropped, so the engine reports no data for it and Polestar's arrow points
// straight, instead of the engine raising a Lua error when a search crosses
// a cluster whose graph it cannot read. Without the client's decoder
// (C_EncodingUtil) every map is dropped. Checks from docs/NAV_QA.md name
// their row (C17: a missing or unloadable map file).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon, tocFiles, ADDONS } = require('./helpers/lua');

const NAV = path.join(ADDONS, 'Polestar_Nav');
const T = 1600 / 3;

// The cluster of a world point on `map` (its metadata file's frame), and the part file holding its graph.
function partOf(map, wx, wy) {
	const meta = fs.readFileSync(path.join(NAV, 'Nav', `Nav${map}.lua`), 'utf8');
	const num = (k) => Number(new RegExp(`\\t${k} = (-?\\d+),`).exec(meta)[1]);
	const k = (Math.floor(wx / T) - num('cx0')) * num('ny') + (Math.floor(wy / T) - num('cy0'));
	const re = new RegExp(`^Nav${map}_\\d+\\.lua$`);
	const file = fs.readdirSync(path.join(NAV, 'Nav')).find((f) => re.test(f) && fs.readFileSync(path.join(NAV, 'Nav', f), 'utf8').includes(`.graph[${k + 1}] = `));
	return { k, file };
}

// Walks crossing several clusters (and part files): Stranglethorn's jungle to Goldshire,
// the Crossroads to Camp Taurajo.
const WALKS = {
	0: [[-11920, -480], [-9444.062, 77.667]],
	1: [[-440, -2650], [-2373.69, -1835.75]],
};

// A part file of `map` holding a cluster the walk crosses, but neither end's.
function middlePart(map) {
	const [a, b] = WALKS[map];
	const ends = new Set([partOf(map, ...a).file, partOf(map, ...b).file]);
	for (const t of [0.5, 0.45, 0.55, 0.4, 0.6, 0.35, 0.65, 0.3, 0.7]) {
		const { file } = partOf(map, a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t);
		if (file && !ends.has(file)) return file;
	}
	return null;
}

// Polestar_Nav's files without `drop`, relative to its folder.
const without = (drop) => tocFiles('Polestar_Nav').map((f) => path.relative(NAV, f)).filter((f) => path.basename(f) !== drop);

const WALK = (map) => `
local Path = Polestar_NavEngine
local frames = {}
Path.after = function(fn) frames[#frames + 1] = fn end
local ok, pts, why = pcall(Path.FindSync, ${map}, { x = ${WALKS[map][0][0]}, y = ${WALKS[map][0][1]} }, { x = ${WALKS[map][1][0]}, y = ${WALKS[map][1][1]} })
local got
Path.Find(${map}, { x = ${WALKS[map][0][0]}, y = ${WALKS[map][0][1]} }, { x = ${WALKS[map][1][0]}, y = ${WALKS[map][1][1]} }, function(points, reason) got = { found = points ~= nil, reason = reason } end)
while #frames > 0 do table.remove(frames, 1)() end
emit({ ok = ok, found = ok and pts ~= nil, why = (ok and not pts) and why or (not ok and tostring(pts)) or nil, available = { Path.Available(0), Path.Available(1), Path.Available(2991) }, async = got })`;

for (const map of [0, 1]) {
	test(`C17: a part file of map ${map} missing from the folder drops that map (no data, the straight arrow), with no Lua error; the other maps still route`, () => {
		const drop = middlePart(map);
		assert.ok(drop, `a part file holding a cluster between the walk's ends (map ${map})`);
		const [whole] = runAddon({ stubs: ['stub_encoding.lua'], addons: ['Polestar_Nav'], script: WALK(map) }).emitted;
		assert.equal(whole.found, true, `with every file the walk routes (map ${map})`);
		const [out] = runAddon({ stubs: ['stub_encoding.lua'], addons: [{ name: 'Polestar_Nav', files: without(drop) }], script: WALK(map) }).emitted;
		assert.equal(out.ok, true, `no Lua error without ${drop}: ${out.why}`);
		assert.equal(out.found, false);
		assert.equal(out.why, 'nodata', 'the map is dropped whole');
		assert.deepEqual(out.async, { found: false, reason: 'nodata' }, 'a sliced search reports no data, never the error handler');
		assert.deepEqual(out.available, [map !== 0, map !== 1, true], 'only that map');
	});
}

test('without the client\'s decoder (C_EncodingUtil) every map reports no data, with no Lua error', () => {
	const [out] = runAddon({ addons: ['Polestar_Nav'], before: 'C_EncodingUtil = nil', script: WALK(0) }).emitted;
	assert.equal(out.ok, true, out.why);
	assert.equal(out.why, 'nodata');
	assert.deepEqual(out.available, [false, false, false]);
});
