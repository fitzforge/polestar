// Regenerates the nav-pack golden (README.md) with a JS checkout's walking-map writer, composed as its
// tools/commands/nav.js `nav pack` composed it (packPlaces, zoneLookup, packLayers), on this folder's inputs and
// ../nav-grid/nav4.
//   node rust/tests/golden/nav-pack/regen.js <js root> rust/tests/golden/nav-pack
const fs = require('node:fs');
const path = require('node:path');

const [, , JS, P] = process.argv;
if (!JS || !P) {
	console.error('usage: node regen.js <js root> <nav-pack dir>');
	process.exit(2);
}
const T = path.resolve(JS, 'tools');
const readJson = (f) => JSON.parse(fs.readFileSync(f, 'utf8'));
const { Geo } = require(path.join(T, 'lib/planner/geo'));
const { areaNames } = require(path.join(T, 'lib/nav/chokepoints'));
const { parseCsv } = require(path.join(T, 'lib/data/csv'));
const { Frames } = require(path.join(T, 'lib/travel/geo'));
const { packNav, shipPack, readLayers } = require(path.join(T, 'lib/nav/pack'));

const areaTable = parseCsv(fs.readFileSync(path.join(P, 'data/AreaTable.csv'), 'utf8'));
const zonesJson = readJson(path.join(P, 'data/zones.json'));
const mapFrames = readJson(path.join(P, 'data/map-frames.json'));
const frames = new Frames(mapFrames.era, zonesJson);
const zoneAt = (c, x, y) => {
	const z = frames.containing(c, x, y).map((m) => zonesJson[String(m.map)]).find((m) => m && m.areaId);
	return z ? Number(z.areaId) : 0;
};

(async () => {
	const dir = path.join(P, '..', 'nav-grid', 'nav4');
	const places = { aids: readJson(path.join(P, 'aids.json')), lifts: readJson(path.join(dir, 'lifts.json')), geo: new Geo(mapFrames, zonesJson), areas: areaNames(areaTable) };
	const layers = readLayers({ dir: path.join(P, 'nav-layers'), areaTable, zoneAt, zones: zonesJson });
	for (const [cells, name] of [[128, 'Polestar_Nav'], [32, 'Polestar_Nav-32']]) {
		const files = await packNav({ dir, cells, continents: [0], places, layers, date: '2026-10-23', log: () => {} });
		shipPack(files, path.join(P, name));
	}
})().catch((e) => {
	console.error(e);
	process.exit(1);
});
