'use strict';
// Every shipped card that paints a zone (UI.ZoneArt) has a painting to show,
// never the bare night band (Fitz, 2026-11-14: "Missing game art for these
// zones" on Forever's dungeon cards). The guide menu, the route choice cards,
// the guide-end window and the welcome paint a guide's `zone`; a dungeon card
// its entrance's zone, else the zone its page places it in, else its loading
// screen (Dungeons/Art.lua); the Rares page the world map for a rare no source
// places.
//
// Which maps the client paints: every map UI/ZoneArtOverlays.lua lists (its
// overlays come from the client's UiMapXMapArt tables), plus the client's maps
// with art and no exploration overlays, listed below (UiMapXMapArt and
// UiMapArtTile, build 1.60.1.70374).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.join(__dirname, '..');
const ADDON = path.join(ROOT, 'addon');
const read = (...p) => fs.readFileSync(path.join(ADDON, ...p), 'utf8');

const NO_OVERLAYS = {
	947: 'Azeroth', 1414: 'Kalimdor', 1415: 'Eastern Kingdoms', 1453: 'Stormwind City', 1454: 'Orgrimmar', 1455: 'Ironforge',
	1456: 'Thunder Bluff', 1457: 'Darnassus', 1458: 'Undercity', 1460: 'Alterac Valley', 1461: 'Arathi Basin', 2524: 'Darkspear Islands', 2665: 'Zephras Isle',
};

function paintedMaps() {
	const maps = new Set(Object.keys(NO_OVERLAYS).map(Number));
	for (const m of read('Polestar', 'UI', 'ZoneArtOverlays.lua').matchAll(/^\t\[\d+\] = \{ \d+, \d+, -- .+ \((\d+)\)$/gm)) maps.add(Number(m[1]));
	return maps;
}

// Every RegisterGuide header of the shipped guide packs: { file, id, zone }.
function shippedGuides() {
	const out = [];
	for (const dir of fs.readdirSync(ADDON).filter((d) => /^Polestar_(Guides|Experimental)/.test(d))) {
		const file = path.join(ADDON, dir, 'Guides.lua');
		if (!fs.existsSync(file)) continue;
		for (const block of fs.readFileSync(file, 'utf8').split('RegisterGuide({').slice(1)) {
			const head = block.slice(0, block.indexOf('steps = '));
			const id = (/\bid = "([^"]+)"/.exec(head) || [])[1];
			const zone = /\bzone = (\d+),/.exec(head);
			out.push({ file: dir, id, zone: zone ? Number(zone[1]) : null });
		}
	}
	return out;
}

// Dungeons/Art.lua's loading screens, by instance Map id.
function loadingScreens() {
	return new Set([...read('Polestar', 'Dungeons', 'Art.lua').matchAll(/^\t\[(\d+)\] = \{ file = \d+,/gm)].map((m) => Number(m[1])));
}

test('the painted-map list reads the overlay table (45 zones) and the maps without overlays', () => {
	const maps = paintedMaps();
	assert.ok(maps.size >= 45 + Object.keys(NO_OVERLAYS).length, `${maps.size} maps`);
	for (const id of [1411, 1447, 2482, 2548, 2652, 2521]) assert.ok(maps.has(id), `${id}: Durotar, Azshara and the Forever zones (Mount Hyjal, Riverglades, Shen'dralas, Zephras Isle)`);
});

test('every shipped guide names a zone the client paints (the guide menu, route choice, guide end, welcome)', () => {
	const maps = paintedMaps();
	const guides = shippedGuides();
	assert.ok(guides.length > 200, `${guides.length} guides read`);
	const bad = guides.filter((g) => !maps.has(g.zone)).map((g) => `${g.file} ${g.id}: zone ${g.zone}`);
	assert.deepEqual(bad, []);
});

test("every dungeon has art: a painted zone for each recorded door, and each one's loading screen for a dungeon no zone is known for", () => {
	const maps = paintedMaps();
	const screens = loadingScreens();
	const doors = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'codex', 'entrances.json'), 'utf8')).entrances;
	for (const e of doors) {
		assert.ok(maps.has(e.map), `${e.key}: its door's zone ${e.map} is painted`);
		assert.ok(screens.has(e.instance), `${e.key}: a loading screen for map ${e.instance}`);
	}
	// Forever's dungeons with no recorded door and no corpse point (client Map rows 2974, 2994, 3001):
	// Blackmaw Hold and The Shaper's Terrace take a zone from the client's areas, Alcaz Prison has none.
	for (const [id, name] of [[2974, 'Blackmaw Hold'], [2994, 'Alcaz Prison'], [3001, "The Shaper's Terrace"]]) assert.ok(screens.has(id), `${name} (${id}): a loading screen`);
});

test('the fixed paintings: the Rares page world map, the Options preview hero zone', () => {
	const maps = paintedMaps();
	const world = /local WORLD, DIM = (\d+),/.exec(read('Polestar', 'Rares', 'View.lua'));
	assert.ok(world && maps.has(Number(world[1])), 'the Rares page: the world map');
	const hero = /local HERO_SCENE = \{\s*zone = (\d+),/.exec(read('Polestar_Options', 'UI', 'Preview.lua'));
	assert.ok(hero && maps.has(Number(hero[1])), 'the Options preview: Elwynn Forest');
});
