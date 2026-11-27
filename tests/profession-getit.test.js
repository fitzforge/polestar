'use strict';
// The profession guides' "Get it" steps (#3661): the farm for a material is picked by rule from our own data.
// The compiler's half (tools/lib/dsl/farmspots.js, Rust forge-guide farmspots.rs): every zone with droppers keeps its
// best camp per level band, `rate` is items per looted kill, a lone mob is no farm, Timbermaw furbolgs never are. The
// Engine's half (Core/Engine.lua pickFor, Own.farmView): of those, the spots of the player's faction whose weakest
// mobs are less than 2 levels above them, by travel plus farm time (lower mobs die faster, denser camps and better
// rates farm faster), re-picked on level-up; the guide window's numbers: kills, minutes, a second choice, and "above
// you" when nothing at the player's level is left. Real data (data/forever), real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');
const { DATA, needs } = require('./helpers/data');

const skip = needs('items.json', 'npcs.json', 'zones.json', 'map-frames.json', 'professions.json', 'objects.json', 'quests.json');

let cache;
function world() {
	if (cache) return cache;
	const { loadData } = require('../tools/lib/dsl/data');
	const data = loadData(DATA);
	const frames = JSON.parse(fs.readFileSync(path.join(DATA, 'map-frames.json'), 'utf8')).era || {};
	cache = { data, frames };
	return cache;
}

const LINEN = 2589;
const WOOL = 2592;
const SILK = 4306;
const MAGEWEAVE = 4338;
const RUNECLOTH = 14047;

function spotsOf(item) {
	const { farmSpots } = require('../tools/lib/dsl/farmspots');
	return farmSpots(world().data, item);
}

const lua = (s) => JSON.stringify(String(s));

// The real Engine picks one of the item's compiled farm spots for a character standing at `at`.
// -> { name, map, lvl, farm, picks: [after each `then` level] }
function pick(item, count, who, at, thenLevels = [], navStub = '') {
	const { data, frames } = world();
	const spots = spotsOf(item);
	const maps = new Set([at.map, ...spots.map((s) => s.map)]);
	const addMaps = [...maps]
		.filter((m) => frames[m])
		.map((m) => {
			const f = frames[m];
			const z = data.zone(m);
			return `w.addMap(${m}, { name = ${lua((z && z.name) || `Map ${m}`)}, c = ${f.c}, left = ${f.left}, right = ${f.right}, top = ${f.top}, bottom = ${f.bottom} })`;
		})
		.join('\n');
	const cands = spots
		.map((s) => `{ npc = ${s.npc}, npcName = ${lua(s.npcName)}, map = ${s.map}, x = ${s.x}, y = ${s.y}, faction = ${lua(s.faction)}, lvl = { min = ${s.lvl.min}, max = ${s.lvl.max} }, rate = ${s.rate}, spawns = ${s.spawns} }`)
		.join(',\n');
	const zone = data.zone(at.map);
	const { emitted } = runAddon({
		stubs: ['stub_world.lua'],
		before: `
local w = stub.world
${addMaps}
w.race, w.raceName, w.faction = ${lua(who.race)}, ${lua(who.race)}, ${lua(who.faction)}
w.level = ${who.level}
w.moveTo(${at.map}, ${at.x}, ${at.y})
w.zone, w.subzone = ${lua(zone ? zone.name : '')}, ""
`,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		script: `${TEST_PACK}
${TEST_SOURCE}
Polestar.RegisterGuide({ id = "test/getit", pack = "test", title = "Get it", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Get it", goals = { { t = "collect", item = ${item}, itemName = "Cloth", count = ${count}, candidates = {
${cands}
	} } } },
	{ goals = { { t = "level", level = 60 } } },
} })
E = Polestar.Engine
local w = stub.world
${navStub}
stub.login()
E.SetGuide("test/getit")
stub.advance(0.6)
local function view()
	local v = E.GetStepView(1).goals[1]
	return { name = v.npcName or false, map = v.map or false, lvl = v.lvl or false, farm = v.farm or false }
end
local out = view()
out.picks = {}
for _, level in ipairs({ ${thenLevels.join(', ')} }) do
	w.setLevel(level)
	stub.advance(0.6)
	out.picks[#out.picks + 1] = view()
end
emit(out)`,
	});
	return emitted[0];
}

function spotFor(item, name, map) {
	return spotsOf(item).find((s) => s.npcName === name && s.map === map);
}

// What every pick must hold: a spot of the player's faction (or contested), weakest mobs under 2 levels above them,
// and the window's numbers: kills from the spot's items per kill, minutes, a second choice on another map.
function checkPick(out, item, who, count) {
	assert.ok(out.name, JSON.stringify(out));
	const s = spotFor(item, out.name, out.map);
	assert.ok(s, `${out.name} on map ${out.map} is one of the compiled spots`);
	assert.ok(s.faction === 'AH' || s.faction === (who.faction === 'Alliance' ? 'A' : 'H'), `${out.name}: ${s.faction} spot for ${who.faction}`);
	assert.ok(s.lvl.min - who.level < 2, `${out.name} (${s.lvl.min}-${s.lvl.max}) is not 2+ above level ${who.level}`);
	assert.equal(out.farm.kills, Math.ceil(count / s.rate));
	assert.ok(out.farm.minutes > 0, JSON.stringify(out.farm));
	assert.ok(out.farm.second && out.farm.second.npcName, JSON.stringify(out.farm));
	assert.notEqual(out.farm.second.map, out.map, 'the second choice is in another zone');
	// One level above is a farm the window marks ("1 level above you: careful"); at or below, no mark.
	assert.equal(out.farm.above, s.lvl.min > who.level ? s.lvl.min - who.level : undefined);
	return s;
}

const HUMAN = { race: 'Human', faction: 'Alliance' };
const ORC = { race: 'Orc', faction: 'Horde' };
const UNDEAD = { race: 'Scourge', faction: 'Horde' };
const NIGHT_ELF = { race: 'NightElf', faction: 'Alliance' };
const at = (map, x, y) => ({ map, x, y });

test('compiled farm spots: every starting area keeps a Linen Cloth camp of its level; no lone mob, no Timbermaw', { skip }, () => {
	const linen = spotsOf(LINEN);
	const zones = new Set(linen.map((s) => s.map));
	// Elwynn Forest, Westfall, Dun Morogh, Teldrassil, Darkshore; Tirisfal Glades, Silverpine Forest, Durotar, Mulgore, The Barrens.
	for (const map of [1429, 1436, 1426, 1438, 1439, 1420, 1421, 1411, 1412, 1413]) assert.ok(zones.has(map), `Linen Cloth spot in map ${map}`);
	for (const item of [LINEN, WOOL, SILK, MAGEWEAVE, RUNECLOTH]) {
		const spots = spotsOf(item);
		assert.ok(spots.every((s) => s.spawns >= 3), `${item}: every spot a camp of 3+`);
		assert.ok(!spots.some((s) => /Timbermaw/.test(s.npcName)), `${item}: no Timbermaw furbolg`);
		assert.ok(spots.length <= 64, `${item}: at most 32 per continent`);
	}
	// Items per kill: Linen Cloth drops one to three at a time (the recordings' yield 1.53 times the chance).
	const elwynn = linen.filter((s) => s.map === 1429);
	assert.ok(elwynn.length && elwynn.every((s) => s.rate > 0.3 && s.rate < 0.7), JSON.stringify(elwynn));
	// A camp counts every dropper standing in it, every spawn: The Barrens' Venture Co. camps are camps of 15+.
	assert.ok(linen.some((s) => s.map === 1413 && s.spawns >= 15), JSON.stringify(linen.filter((s) => s.map === 1413)));
	// Named for the kind most of the camp is, not the one named mob among them.
	assert.ok(!linen.some((s) => /^(Gazz'uz|Gorehoof the Black)$/.test(s.npcName)), JSON.stringify(linen.map((s) => s.npcName)));
	// A mob tagged for the Alliance (Hillsbrad's farmers and miners) is the Horde's farm, in a contested zone.
	assert.ok(spotsOf(WOOL).some((s) => s.map === 1424 && s.faction === 'H'), JSON.stringify(spotsOf(WOOL).filter((s) => s.map === 1424)));
});

// A continent's maps (the era frames' `c`).
const onContinent = (map, c) => world().frames[map] && world().frames[map].c === c;

test('Linen Cloth at level 10: a Human by Goldshire and an Orc at Razor Hill each farm a camp of their side on their own continent', { skip }, () => {
	const human = pick(LINEN, 60, { ...HUMAN, level: 10 }, at(1429, 42.1, 65.9));
	checkPick(human, LINEN, { ...HUMAN, level: 10 }, 60);
	assert.ok(onContinent(human.map, 0), JSON.stringify(human));
	const orc = pick(LINEN, 60, { ...ORC, level: 10 }, at(1411, 52.0, 43.0));
	checkPick(orc, LINEN, { ...ORC, level: 10 }, 60);
	assert.ok(onContinent(orc.map, 1), JSON.stringify(orc));
	assert.notEqual(human.name, orc.name);
});

test('Wool Cloth at 18 by Sentinel Hill (Human) and the Sepulcher (Undead): a camp of their own continent at their level', { skip }, () => {
	const human = pick(WOOL, 100, { ...HUMAN, level: 18 }, at(1436, 56.3, 47.5));
	checkPick(human, WOOL, { ...HUMAN, level: 18 }, 100);
	const undead = pick(WOOL, 100, { ...UNDEAD, level: 18 }, at(1421, 43.0, 41.0));
	checkPick(undead, WOOL, { ...UNDEAD, level: 18 }, 100);
	assert.ok(onContinent(human.map, 0) && onContinent(undead.map, 0), JSON.stringify([human, undead]));
});

test('Silk Cloth at 30, Mageweave Cloth at 42, Runecloth at 55: a farm at the level, never 2+ above', { skip }, () => {
	checkPick(pick(SILK, 200, { ...HUMAN, level: 30 }, at(1431, 73.9, 44.5)), SILK, { ...HUMAN, level: 30 }, 200);
	checkPick(pick(SILK, 200, { ...ORC, level: 30 }, at(1413, 51.5, 30.3)), SILK, { ...ORC, level: 30 }, 200);
	checkPick(pick(MAGEWEAVE, 300, { ...HUMAN, level: 42 }, at(1417, 45.8, 47.6)), MAGEWEAVE, { ...HUMAN, level: 42 }, 300);
	checkPick(pick(MAGEWEAVE, 300, { ...ORC, level: 42 }, at(1446, 52.5, 28.0)), MAGEWEAVE, { ...ORC, level: 42 }, 300);
	checkPick(pick(RUNECLOTH, 400, { ...HUMAN, level: 55 }, at(1423, 75.7, 53.0)), RUNECLOTH, { ...HUMAN, level: 55 }, 400);
	checkPick(pick(RUNECLOTH, 400, { ...ORC, level: 55 }, at(1448, 34.5, 53.0)), RUNECLOTH, { ...ORC, level: 55 }, 400);
});

test('below every spot: a level 3 Night Elf still gets the nearest farm, and the window says how far above them it is', { skip }, () => {
	const out = pick(MAGEWEAVE, 20, { ...NIGHT_ELF, level: 3 }, at(1438, 55.9, 57.0));
	const s = spotFor(MAGEWEAVE, out.name, out.map);
	assert.ok(s && s.lvl.min - 3 >= 2, JSON.stringify(out));
	assert.equal(out.farm.above, s.lvl.min - 3);
});

test('re-picked on level-up: a Linen Cloth farm for level 6 gives way once the player outlevels it', { skip }, () => {
	const out = pick(LINEN, 60, { ...HUMAN, level: 6 }, at(1429, 42.1, 65.9), [16]);
	const low = checkPick(out, LINEN, { ...HUMAN, level: 6 }, 60);
	assert.ok(low.lvl.min <= 7, JSON.stringify(low));
	const later = out.picks[0];
	checkPick(later, LINEN, { ...HUMAN, level: 16 }, 60);
	// Fewer minutes once the old camp's mobs are green or grey to the player.
	assert.ok(later.farm.minutes < out.farm.minutes, `${out.farm.minutes} -> ${later.farm.minutes}`);
});

// The profession guides as `profession draft` writes them from data/forever.
function draft(name) {
	const { draftGuide, draftData } = require('../tools/lib/professions/guide');
	return draftGuide(name, draftData(DATA)).text;
}

// A guide's Get it steps for a material: [{ title, only, zone, lines }].
function getIts(text, material) {
	return text
		.split('\n\n')
		.filter((b) => b.startsWith(`step Get ${material}`))
		.map((b) => {
			const lines = b.split('\n');
			const val = (k) => (lines.find((l) => l.startsWith(`  ${k} `)) || '').slice(k.length + 3) || null;
			return { title: lines[0].slice(5), only: val('only'), zone: val('zone'), lines };
		});
}

test('Light and Medium Leather: a Get it step per starting area or faction, at beasts of the leather\'s levels, the Auction House last', { skip }, () => {
	const text = draft('Leatherworking');
	const light = getIts(text, 'Light Leather');
	// Each starting area skins at home: Elwynn Forest for Humans, Teldrassil for Night Elves, Durotar for Orcs and Trolls ...
	const zones = Object.fromEntries(light.map((g) => [g.only, g.zone]));
	assert.equal(zones.Human, 'Elwynn Forest');
	assert.equal(zones.NightElf, 'Teldrassil');
	assert.equal(zones['Orc,Troll'], 'Durotar');
	assert.equal(zones.Tauren, 'Mulgore');
	for (const g of light) {
		assert.match(g.lines.join('\n'), /Skinning: beasts of level 5-20\./, g.title);
		assert.match(g.lines.at(-2), /^ {2}collect 2318 x\d+ @[\d.]+,[\d.]+ (era|live) gather Skinning 1$/, g.title);
		assert.match(g.lines.at(-1), /^ {2}auction 2318 x\d+$/, g.title);
	}
	const medium = getIts(text, 'Medium Leather');
	assert.ok(medium.length >= 2, text.slice(0, 200));
	for (const g of medium) {
		assert.match(g.lines.join('\n'), /Skinning: beasts of level 18-30\./, g.title);
		assert.match(g.lines.at(-1), /^ {2}auction 2319 x\d+$/, g.title);
	}
});

test('Iron Bar: each faction mines Iron Deposits in a zone of its own side or a contested one, and smelts them; the Auction House last', { skip }, () => {
	const { ZONES } = require('../tools/lib/professions/gathering/tables');
	const { data } = world();
	const iron = getIts(draft('Blacksmithing'), 'Iron Bar');
	assert.deepEqual(iron.map((g) => g.only).sort(), ['Alliance', 'Horde']);
	for (const g of iron) {
		const map = Object.keys(ZONES).find((m) => (data.zone(Number(m)) || {}).name === g.zone);
		assert.ok(map && (ZONES[map].side === 'AH' || ZONES[map].side === g.only[0]), `${g.title}: ${g.zone}`);
		assert.match(g.lines.join('\n'), /Mine Iron Deposit \(Mining 125\) for Iron Ore and smelt it at a forge/);
		assert.match(g.lines.at(-2), /^ {2}collect 3575 x\d+ @[\d.]+,[\d.]+ era gather Mining 125$/);
		assert.match(g.lines.at(-1), /^ {2}auction 3575 x\d+$/);
	}
});

test('the farm is ranked by the travel planner from where the player stands (flights, Hearthstone), not from a point', { skip }, () => {
	// The planner says only the Westfall camp is close by its own way (a flight, the Hearthstone), and only when asked
	// for the player's own trip (no `from`): that camp wins over the camps a straight line puts nearer.
	const nav = `Polestar.Nav = { EstimateTravel = function(from, to) if from == nil and to.map == 1436 then return 1 end return 100000 end }`;
	const out = pick(LINEN, 60, { ...HUMAN, level: 12 }, at(1429, 42.1, 65.9), [], nav);
	assert.equal(out.map, 1436, JSON.stringify(out));
});
