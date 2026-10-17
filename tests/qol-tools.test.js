'use strict';
// Quality of Life toolchain: `qol build` (Spirit Healers and flight masters
// -> addon/Polestar/QoL/Data.lua) and the qol media generator.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { buildQolData, toLua } = require('../tools/commands/qol');
const media = require('../tools/media/qol');
const { runAddon } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');

const FRAMES = { era: { 1429: { c: 0, left: 1000, right: -1000, top: 1000, bottom: -1000 } } };

test('qol build: Spirit Healers by exact name, nearby points merged, world yards from the Era frame', () => {
	const npcs = {
		6491: { id: 6491, name: 'Spirit Healer', roles: ['spirithealer'], spawns: { 1429: { f: 'e', pts: [[50, 50], [50.5, 50], [10, 90]] }, 9999: { f: 'e', pts: [[1, 1]] } } },
		13116: { id: 13116, name: 'Alliance Spirit Guide', roles: ['spirithealer'], spawns: { 1429: { f: 'e', pts: [[20, 20]] } } },
		18153: { id: 18153, name: 'Spirit Healer (DND)', spawns: { 1429: { f: 'e', pts: [[30, 30]] } } },
		352: { id: 352, name: 'Dungar Longdrink', roles: ['flightmaster', 'vendor'] },
		12: { id: 12, name: 'Somebody', roles: ['vendor'] },
		931: { id: 931, name: 'Ariena Stormfeather', roles: ['flightmaster'] },
		1275: { id: 1275, name: 'Kyra Boucher', roles: ['vendor'], subName: 'Reagent Vendor' },
		3335: { id: 3335, name: 'Hagrus', roles: ['vendor'], subName: 'Reagents & Poisons' },
		4000: { id: 4000, name: 'Crate Clerk', roles: ['vendor'], subName: 'PTR - Crate Turn-In Reagents' },
		4001: { id: 4001, name: 'Not A Vendor', subName: 'Reagent Vendor' },
	};
	const d = buildQolData({ npcs, frames: FRAMES });
	assert.equal(d.healers.length, 2, '(50,50) and (50.5,50) are 10 yd apart: one healer');
	const centre = d.healers.find((h) => h.x === 50);
	assert.deepEqual([centre.c, centre.wx, centre.wy], [0, 0, 0]);
	const corner = d.healers.find((h) => h.x === 10);
	assert.deepEqual([corner.wx, corner.wy], [-800, 800]);
	assert.deepEqual(d.flightMasters, [352, 931]);
	assert.deepEqual(d.reagentVendors, [1275, 3335], 'vendors whose subtitle names reagents; test-realm clerks stay out');
	assert.equal(d.skipped.length, 1, 'a map without a frame is reported');

	const lua = toLua(d);
	assert.match(lua, /QoL\.SetData\(\{/);
	assert.match(lua, /\{0,0,0,1429,50,50\},/);
	assert.match(lua, /352, 931,/);
	assert.match(lua, /reagentVendors = \{\n\t\t1275, 3335,\n\t\},/);
});

test('qol build: generated Lua loads into the addon namespace', () => {
	const d = buildQolData({
		npcs: { 1: { id: 1, name: 'Spirit Healer', spawns: { 1429: { f: 'e', pts: [[50, 50]] } } }, 2: { id: 2, name: 'F', roles: ['flightmaster'] }, 3: { id: 3, name: 'R', roles: ['vendor'], subName: 'Reagents' } },
		frames: FRAMES,
	});
	const file = path.join(os.tmpdir(), `qol-data-${process.pid}.lua`);
	fs.writeFileSync(file, toLua(d));
	try {
		const [r] = runAddon({
			script: `
				local ns = { QoL = {} }
				function ns.QoL.SetData(t) ns.data = t end
				loadfile(${JSON.stringify(file)})("Polestar", ns)
				emit({ healers = #ns.data.spiritHealers, first = ns.data.spiritHealers[1], fm = ns.data.flightMasters, reagents = ns.data.reagentVendors })
			`,
		}).emitted;
		assert.deepEqual(r, { healers: 1, first: [0, 0, 0, 1429, 50, 50], fm: [2], reagents: [3] });
	} finally {
		fs.rmSync(file, { force: true });
	}
});

test('qol media: power-of-two TGA glyphs under Media/UI with the qol- prefix', () => {
	const root = tmpdir('qol-media-');
	const written = media.generate(root);
	assert.equal(media.name, 'qol');
	assert.deepEqual(written.map((f) => path.basename(f, '.tga')).sort(), [...media.textures].sort());
	for (const f of written) {
		assert.equal(path.dirname(f), path.join(root, 'Media', 'UI'));
		const b = fs.readFileSync(f);
		assert.equal(b[2], 2, 'uncompressed true-colour');
		assert.deepEqual([b.readUInt16LE(12), b.readUInt16LE(14)], [32, 32]);
		let ink = 0;
		for (let i = 18 + 3; i < b.length; i += 4) if (b[i] > 128) ink++;
		assert.ok(ink > 40, `${path.basename(f)} draws something`);
	}
});

test('qol media: every glyph the addon references is generated and committed', () => {
	const src = ['Buttons.lua', 'Rewards.lua', 'Flight.lua', 'Death.lua', 'Options.lua']
		.map((f) => fs.readFileSync(path.join(__dirname, '..', 'addon', 'Polestar', 'QoL', f), 'utf8'))
		.join('\n');
	const used = new Set(src.match(/qol-[a-z]+(?:-[a-z]+)*/g));
	for (const name of used) {
		assert.ok(media.textures.includes(name), `${name} generated`);
		assert.ok(fs.existsSync(path.join(__dirname, '..', 'addon', 'Polestar', 'Media', 'UI', `${name}.tga`)), `${name}.tga committed`);
	}
});
