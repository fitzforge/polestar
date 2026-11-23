'use strict';
// The studio's zone paintings come from the client's map tables
// (tools/studio/clientdata.js zoneArt, art.js addMaps), not from whatever
// maps an art cache was filled with by hand: a cache without Wetlands drew
// the guide end's "Next: Wetlands, Dustwallow Marsh & Thousand Needles" over
// the night band, where the game paints Wetlands.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');

const clientData = require('../tools/studio/clientdata');
const art = require('../tools/studio/art');

// Wetlands (uiMap 1437) as the client's tables list it: art 2166 (a later
// phase's art 9999 is not the one shown), style 7's layer 0 of 2 x 1 tiles,
// and one overlay with two tiles. A map with no art layer (1) is left out.
const TABLES = {
	UiMapXMapArt: [
		{ ID: 2, PhaseID: 5, UiMapArtID: 9999, UiMapID: 1437 },
		{ ID: 1, PhaseID: 0, UiMapArtID: 2166, UiMapID: 1437 },
		{ ID: 3, PhaseID: 0, UiMapArtID: 3000, UiMapID: 1 },
	],
	UiMapArt: [{ ID: 2166, UiMapArtStyleID: 7 }, { ID: 9999, UiMapArtStyleID: 7 }, { ID: 3000, UiMapArtStyleID: 8 }],
	UiMapArtStyleLayer: [
		{ ID: 1, LayerIndex: 0, LayerWidth: 400, LayerHeight: 200, TileWidth: 256, TileHeight: 256, UiMapArtStyleID: 7 },
		{ ID: 2, LayerIndex: 1, LayerWidth: 10, LayerHeight: 10, TileWidth: 10, TileHeight: 10, UiMapArtStyleID: 7 },
	],
	UiMapArtTile: [
		{ ID: 11, RowIndex: 0, ColIndex: 1, LayerIndex: 0, FileDataID: 102, UiMapArtID: 2166 },
		{ ID: 10, RowIndex: 0, ColIndex: 0, LayerIndex: 0, FileDataID: 101, UiMapArtID: 2166 },
		{ ID: 12, RowIndex: 0, ColIndex: 0, LayerIndex: 1, FileDataID: 103, UiMapArtID: 2166 },
		{ ID: 13, RowIndex: 0, ColIndex: 0, LayerIndex: 0, FileDataID: 199, UiMapArtID: 9999 },
	],
	WorldMapOverlay: [{ ID: 50, UiMapArtID: 2166 }, { ID: 51, UiMapArtID: 9999 }],
	WorldMapOverlayTile: [
		{ ID: 1, WorldMapOverlayID: 50, FileDataID: 201 },
		{ ID: 2, WorldMapOverlayID: 50, FileDataID: 202 },
		{ ID: 3, WorldMapOverlayID: 51, FileDataID: 299 },
	],
};
const read = async (name) => TABLES[name].map((r) => Object.fromEntries(Object.entries(r).map(([k, v]) => [k, String(v)])));

test('the studio\'s zone art is every painting the client\'s map tables list, with its tiles and overlay tiles', async () => {
	const z = await clientData.zoneArt(read);
	assert.deepEqual(z.maps, {
		1437: { artID: 2166, layer: { layerWidth: 400, layerHeight: 200, tileWidth: 256, tileHeight: 256 }, textures: [101, 102] },
	});
	assert.deepEqual(z.files.sort(), [101, 102, 201, 202]);
});

test('a cache without the zone gains it in maps.json; the maps it held stay', async (t) => {
	const dir = tmpdir('polestar-studio-zoneart-');
	const before = process.env.POLESTAR_STUDIO_ART;
	process.env.POLESTAR_STUDIO_ART = dir;
	t.after(() => {
		if (before === undefined) delete process.env.POLESTAR_STUDIO_ART;
		else process.env.POLESTAR_STUDIO_ART = before;
	});
	const other = { artID: 1, layer: { layerWidth: 1, layerHeight: 1, tileWidth: 1, tileHeight: 1 }, textures: [5] };
	fs.writeFileSync(path.join(dir, 'maps.json'), JSON.stringify({ 1429: other }));
	const z = await clientData.zoneArt(read);
	assert.deepEqual(art.addMaps(z.maps), ['1437']);
	const maps = JSON.parse(fs.readFileSync(path.join(dir, 'maps.json'), 'utf8'));
	assert.deepEqual(maps[1437], z.maps[1437]);
	assert.deepEqual(maps[1429], other);
	assert.deepEqual(art.addMaps(z.maps), [], 'nothing to write the second time');
});
