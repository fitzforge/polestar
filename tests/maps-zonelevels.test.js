'use strict';
// Zone level ranges (tools/lib/maps/zonelevels.js -> addon/Polestar/Maps/ZoneLevels.lua):
// the heuristic on fixture data, the generated Lua, and the addon reading it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { zoneLevels, emitLua, buildZoneLevels, foreverOnly } = require('../tools/lib/maps/zonelevels');
const { ROOT } = require('../tools/lib/paths');
const { runAddon } = require('./helpers/lua');
const { DATA, needs } = require('./helpers/data');

function pts(n, x, y) {
	return Array.from({ length: n }, (_, i) => [x + (i % 5), y + Math.floor(i / 5)]);
}

const ZONES = {
	1: { id: 1, name: 'Greenvale', type: 3 },
	2: { id: 2, name: 'Capital', type: 3 },
	3: { id: 3, name: 'Quietmarsh', type: 3 },
	10: { id: 10, name: 'Mainland', type: 2 },
};

const NPCS = {
	// Greenvale: levels 10..20 in bulk, critters at level 1, an elite, a friendly guard.
	100: { id: 100, name: 'Wolf', level: 10, levelMax: 11, faction: null, spawns: { 1: { f: 'e', pts: pts(40, 20, 20) } } },
	101: { id: 101, name: 'Bandit', level: 14, faction: null, spawns: { 1: { f: 'e', pts: pts(60, 40, 40) } } },
	102: { id: 102, name: 'Ogre', level: 18, levelMax: 20, faction: null, spawns: { 1: { f: 'e', pts: pts(30, 60, 60) } } },
	103: { id: 103, name: 'Rabbit', level: 1, faction: null, spawns: { 1: { f: 'e', pts: pts(25, 80, 10) } } },
	104: { id: 104, name: 'Ogre Lord', level: 30, faction: null, rank: 1, spawns: { 1: { f: 'e', pts: pts(50, 70, 70) } } },
	105: { id: 105, name: 'Guard', level: 55, faction: 'AH', spawns: { 1: { f: 'e', pts: pts(10, 50, 50) } } },
	// Capital: many friendly NPCs, a few rats.
	200: { id: 200, name: 'Citizen', level: 30, faction: 'A', spawns: { 2: { f: 'e', pts: pts(300, 10, 10) } } },
	201: { id: 201, name: 'Sewer Rat', level: 5, faction: null, spawns: { 2: { f: 'e', pts: pts(120, 30, 30) } } },
	// Quietmarsh: too little wildlife to say.
	300: { id: 300, name: 'Toad', level: 30, faction: null, spawns: { 3: { f: 'e', pts: pts(20, 50, 50) } } },
};

test('zone range is the spawn-weighted P10..P90 of normal hostile creatures, critters dropped', () => {
	const out = zoneLevels(NPCS, ZONES);
	assert.deepEqual(Object.keys(out), ['1']);
	const g = out[1];
	// 155 spawns: 25 rabbits at 1, 20 at 10, 20 at 11, 60 at 14, 10 each at
	// 18..20. The median is 14, so with the default 15-level gap the rabbits
	// stay (P10 = 1); a 10-level gap drops them and P10 becomes 10. P90 = 19.
	assert.deepEqual([g.min, g.max], [1, 19]);
	const strict = zoneLevels(NPCS, ZONES, { critterGap: 10 })[1];
	assert.deepEqual([strict.min, strict.max], [10, 19]);
	assert.equal(g.name, 'Greenvale');
	assert.equal(g.weight, 155); // hostile normal spawn points, rabbits included
	// Label point: weighted median of kept spawn positions.
	assert.ok(strict.x >= 40 && strict.x <= 45, `x ${strict.x}`);
	assert.ok(strict.y >= 40 && strict.y <= 52, `y ${strict.y}`);
});

test('elites and friendly NPCs never shape a range; sparse or city zones get none', () => {
	const out = zoneLevels(NPCS, ZONES, { critterGap: 10 });
	assert.ok(out[1].max < 30, 'the level 30 elite is ignored');
	assert.equal(out[2], undefined, 'hostile share 120/420 is under 0.4');
	assert.equal(out[3], undefined, '20 spawn points are under the minimum');
	assert.equal(out[10], undefined, 'continents get no range');
	const lenient = zoneLevels(NPCS, ZONES, { minShare: 0.2, minWeight: 10 });
	assert.deepEqual([lenient[2].min, lenient[2].max], [5, 5]);
	assert.deepEqual([lenient[3].min, lenient[3].max], [30, 30]);
});

test('Forever-only zones pass on the sparse thresholds; the rest keep the strict ones', () => {
	// Quietmarsh (3): 20 hostile spawn points, all of its NPCs: under 100, over 0.2 share.
	const out = zoneLevels(NPCS, ZONES, { sparse: [3], sparseMinWeight: 15 });
	assert.deepEqual([out[3].min, out[3].max], [30, 30]);
	assert.equal(out[2], undefined, 'Capital is not sparse: still held to the strict share');
	assert.equal(zoneLevels(NPCS, ZONES, { sparse: [3] })[3], undefined, '20 is under the default sparse minimum of 30');
	assert.deepEqual(foreverOnly({ era: { 1: {}, 2: {} }, forever: { 1: {}, 2: {}, 7: {}, 5: {} } }), [5, 7]);
});

test('the generated Lua registers the ranges and the addon colours them for the player', () => {
	const lua = emitLua(zoneLevels(NPCS, ZONES, { critterGap: 10 }));
	assert.match(lua, /\[1\] = \{ 10, 19, [\d.]+, [\d.]+ \}, -- Greenvale/);
	const file = path.join(require('node:os').tmpdir(), `polestar-zonelevels-${process.pid}.lua`);
	fs.writeFileSync(file, lua);
	try {
		const [out] = runAddon({
			stubs: ['stub_world.lua'],
			addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/Maps.lua', 'Maps/WorldMap.lua'] }],
			login: true,
			script: `
				assert(loadfile(${JSON.stringify(file)}))("Polestar", Polestar)
				local M = Polestar.Maps
				local lo, hi = M.GetZoneLevels(1)
				local each, agree = {}, true
				for id, a, b in M.EachZoneLevels() do
					each[#each + 1] = id
					local x, y = M.GetZoneLevels(id)
					if x ~= a or y ~= b then agree = false end
				end
				table.sort(each)
				local hasTwo = false
				for _, id in ipairs(each) do if id == 2 then hasTwo = true end end
				emit({ lo = lo, hi = hi, none = M.GetZoneLevels(2) or false, text = M.FormatLevels(lo, hi),
					colors = { M.LevelColor(lo, hi, 5), M.LevelColor(lo, hi, 9), M.LevelColor(lo, hi, 12),
						M.LevelColor(lo, hi, 22), M.LevelColor(lo, hi, 40) }, hasOne = each[1] == 1, hasTwo = hasTwo, agree = agree })`,
		}).emitted;
		assert.deepEqual(out, {
			lo: 10, hi: 19, none: false, text: '10–19',
			colors: ['danger', 'warning', 'quest', 'success', 'textMuted'],
			hasOne: true, hasTwo: false, agree: true,
		});
	} finally {
		fs.rmSync(file, { force: true });
	}
});

test('ZoneLevels.lua is up to date with data/forever', { skip: needs('npcs.json', 'zones.json') }, () => {
	const { lua, levels } = buildZoneLevels({ dataDir: DATA });
	const committed = fs.readFileSync(path.join(ROOT, 'addon', 'Polestar', 'Maps', 'ZoneLevels.lua'), 'utf8');
	assert.equal(committed, lua, 'run: node tools/polestar.js maps build');
	// Sanity against the ranges players know.
	assert.deepEqual([levels[1429].min, levels[1429].max], [1, 10]); // Elwynn Forest
	assert.ok(levels[1436].min >= 9 && levels[1436].max <= 20); // Westfall
	assert.ok(levels[1423].min >= 50); // Eastern Plaguelands
	assert.equal(levels[1453], undefined); // Stormwind City
	assert.ok(levels[2521] && levels[2482], 'Forever-only zones with data have ranges (Zephras Isle, Mount Hyjal)');
});
