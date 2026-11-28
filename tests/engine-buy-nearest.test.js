'use strict';
// `buy <item> xN nearest` in the real Engine: the goal's sellers are smart-target `candidates` (forge-guide
// candidates.rs, one per town), and the arrow leads to the one of the character's side nearest where the player stands
// now, picked again when the player changes zones. The profession guides' "Buy a Blacksmith Hammer" (5956), with the
// compiled guide's own sellers and the client's map frames. Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

// The client's frames (C_Map world bounds: top, left, bottom, right in world yards).
const MAPS = `
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, top = 1808.3, left = -1962.5, bottom = -1716.7, right = -7250 })
w.addMap(1412, { name = "Mulgore", c = 1, top = 266.7, left = 2479.2, bottom = -3835.4, right = -3675 })
w.addMap(1413, { name = "The Barrens", c = 1, top = 1612.5, left = 2622.9, bottom = -5143.7, right = -7510.4 })
w.addMap(1440, { name = "Ashenvale", c = 1, top = 4672.9, left = 1700, bottom = 829.2, right = -4066.7 })
w.addMap(1454, { name = "Orgrimmar", c = 1, top = 2273.9, left = -3680.6, bottom = 1338.5, right = -5083.2 })
w.addMap(1456, { name = "Thunder Bluff", c = 1, top = -850, left = 516.7, bottom = -1545.8, right = -527.1 })
w.addMap(1429, { name = "Elwynn Forest", c = 0, top = -7939.6, left = 1535.4, bottom = -10254.2, right = -1935.4 })
w.addMap(1453, { name = "Stormwind City", c = 0, top = -7995.8, left = 1722.9, bottom = -9154.2, right = -14.6 })
w.level = 12
`;

const HORDE = `${MAPS}
w.race, w.raceName, w.faction, w.class, w.className = "Tauren", "Tauren", "Horde", "WARRIOR", "Warrior"
w.moveTo(1412, 47, 58)
w.zone, w.subzone = "Mulgore", "Bloodhoof Village"
`;

const ALLIANCE = `${MAPS}
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.moveTo(1429, 42, 64)
w.zone, w.subzone = "Elwynn Forest", "Goldshire"
`;

// The compiled blacksmithing guide's sellers of the hammer on these maps.
const GUIDE = `
Polestar.RegisterGuide({ id = "test/hammer", pack = "test", title = "Blacksmithing", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Buy a Blacksmith Hammer", goals = { { t = "buy", item = 5956, itemName = "Blacksmith Hammer", count = 1, candidates = {
		{ npc = 3168, npcName = "Flakk", map = 1411, x = 52.89, y = 41.91, faction = "H" },
		{ npc = 3187, npcName = "Tai'tasi", map = 1411, x = 56.33, y = 73.81, faction = "H" },
		{ npc = 267328, npcName = "Norzsh", map = 1411, x = 40.58, y = 68.17, faction = "H" },
		{ npc = 3081, npcName = "Wunna Darkmane", map = 1412, x = 45.45, y = 61.77, faction = "H" },
		{ npc = 267331, npcName = "Vartha Rockmane", map = 1412, x = 44.26, y = 78.46, faction = "H" },
		{ npc = 3477, npcName = "Hraq", map = 1413, x = 51.1, y = 29.01, faction = "H" },
		{ npc = 3495, npcName = "Gagsprocket", map = 1413, x = 62.64, y = 36.3, faction = "AH" },
		{ npc = 1250, npcName = "Drake Lindgren", map = 1429, x = 83.22, y = 66.62, faction = "A" },
		{ npc = 66, npcName = "Tharynn Bouden", map = 1429, x = 41.73, y = 67.03, faction = "A" },
		{ npc = 247226, npcName = "Kelsey Fargo", map = 1429, x = 47.05, y = 32.28, faction = "A" },
		{ npc = 1286, npcName = "Edna Mullby", map = 1453, x = 64.8, y = 71.41, faction = "A" },
		{ npc = 3356, npcName = "Sumi", map = 1454, x = 82.3, y = 23.8, faction = "H" },
		{ npc = 3367, npcName = "Felika", map = 1454, x = 60.6, y = 50.56, faction = "H" },
		{ npc = 5817, npcName = "Shimra", map = 1454, x = 47.92, y = 80.15, faction = "H" },
		{ npc = 2999, npcName = "Taur Stonehoof", map = 1456, x = 39.84, y = 55.65, faction = "H" },
	} } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;

function run(world, script) {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua'],
		before: world,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `${TEST_PACK}
${TEST_SOURCE}
${GUIDE}
E = Polestar.Engine
local w = stub.world
stub.login()
E.SetGuide("test/hammer")
stub.advance(0.6)
local function seller() local wp = E.GetWaypoint(); return wp and { wp.map, wp.x, wp.y } or false end
local function move(map, x, y, zone, subzone)
	w.moveTo(map, x, y); w.zone, w.subzone = zone, subzone
	stub.fire("ZONE_CHANGED_NEW_AREA"); stub.advance(0.6)
end
${script}`,
	});
	return emitted[0];
}

const WUNNA = [1412, 45.45, 61.77];
const FLAKK = [1411, 52.89, 41.91];
const SHIMRA = [1454, 47.92, 80.15];

test('a Tauren at Bloodhoof Village buys the hammer from Wunna Darkmane there, not in Orgrimmar', () => {
	const out = run(HORDE, 'emit({ at = seller() })');
	assert.deepEqual(out.at, WUNNA);
});

test('the seller is picked again on a zone change: Razor Hill in Durotar, Bloodhoof back in Mulgore', () => {
	const out = run(HORDE, `
local first = seller()
move(1411, 54, 46, "Durotar", "Razor Hill")
local durotar = seller()
move(1412, 46, 60, "Mulgore", "Bloodhoof Village")
emit({ first = first, durotar = durotar, back = seller() })`);
	assert.deepEqual(out.first, WUNNA);
	assert.deepEqual(out.durotar, FLAKK, 'Flakk at Razor Hill');
	assert.deepEqual(out.back, WUNNA);
});

test('from east Ashenvale (no seller in the zone) the nearest Horde seller is in Orgrimmar', () => {
	const out = run(HORDE, `
move(1440, 80.66, 58.75, "Ashenvale", "Splintertree Post")
emit({ at = seller() })`);
	assert.deepEqual(out.at, SHIMRA, 'Orgrimmar lies about 1,660 yd away, Razor Hill and the Crossroads about 2,760');
});

test('a Human in Elwynn Forest buys it in Goldshire, never from a Horde seller', () => {
	const out = run(ALLIANCE, 'emit({ at = seller() })');
	assert.deepEqual(out.at, [1429, 41.73, 67.03], 'Tharynn Bouden in Goldshire');
});
