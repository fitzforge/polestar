'use strict';
// The compiler's test fixtures (tests/fixtures/dsl) and helpers to compile
// guides and build packs from them.

const path = require('node:path');
const { tmpdir } = require('./tmp');
const { loadData, Data } = require('../../tools/lib/dsl/data');
const { compileSources, OFFICIAL_DIR } = require('../../tools/lib/dsl/project');
const { readManifest } = require('../../tools/lib/pack/manifest');
const { writePackInto } = require('../../tools/lib/playtest');
const { format } = require('../../tools/lib/dsl/diag');

const FIXTURES = path.join(__dirname, '..', 'fixtures', 'dsl');
const DATA_DIR = path.join(FIXTURES, 'data');
const GUIDES_DIR = path.join(FIXTURES, 'guides');

let cached;
function fixtureData() {
	if (!cached) cached = loadData(DATA_DIR);
	return cached;
}

const HEADER = ['guide t/main', 'title Test', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest'];

// Guide text from lines; without a `guide` line the default header is prepended.
function guideText(lines) {
	const body = Array.isArray(lines) ? lines : lines.split('\n');
	return `${(body[0] || '').startsWith('guide ') ? body.join('\n') : [...HEADER, '', ...body].join('\n')}\n`;
}

// Line number (1-based) of the first line equal to `needle` (trimmed) in text.
function lineOf(text, needle) {
	const i = text.split('\n').findIndex((l) => l.trim() === needle.trim());
	if (i < 0) throw new Error(`line not found: ${needle}`);
	return i + 1;
}

// compile({ 'a.guide': text, ... } | text, data?, { pack }?) -> { guides, diag, errors, warnings }
// errors/warnings are "file:line: message" strings; the guides belong to
// `pack` (ours when absent).
function compile(sources, data = fixtureData(), opts = {}) {
	const map = typeof sources === 'string' ? { 'test.guide': sources } : sources;
	const list = Object.keys(map).map((file) => ({ file, text: map[file] }));
	const { guides, diag } = compileSources(list, data, undefined, opts);
	const strip = (d) => `${d.file}:${d.line}: ${d.message}`;
	return {
		guides,
		diag,
		errors: diag.sorted().filter((d) => d.severity === 'error').map(strip),
		warnings: diag.sorted().filter((d) => d.severity === 'warning').map(strip),
		text: diag.sorted().map(format).join('\n'),
	};
}

// A JSON-plain copy (drops non-enumerable bookkeeping and undefined fields).
function plain(v) {
	return JSON.parse(JSON.stringify(v));
}

// The fixture data plus group content (docs/GUIDE_FORMAT.md, "Group
// content"): 95003 Elite Kobold (rank 1) is already there; 95030 is a
// friendly rank-1 talk credit, 95040 a boss and 95041 a raid boss, both with
// no open-world spawn. Item 95100 drops only from the Elite Kobold, 95101
// also from a normal kobold. Quests 9600 and 9603 (dungeon area, their boss
// inside) and 9601 (raid area) are instance quests; 9602 has the dungeon's
// area but is done outside (a breadcrumb). Marshal McBride gives and takes
// back every one. Area 7001 is the Hollow Deeps, 7002 Molten Core; uiMap
// 9900 is drawn on the Hollow Deeps.
function groupData() {
	const base = fixtureData();
	const npcs = {
		...base.npcs,
		95030: { id: 95030, name: 'Friendly Sage', level: 55, rank: 1, faction: 'AH', spawns: { 1429: { f: 'e', pts: [[40, 40]] } } },
		95040: { id: 95040, name: 'Hollow Lord', level: 30, rank: 3, faction: null, spawns: {} },
		95041: { id: 95041, name: 'Fire Lord', level: 63, rank: 3, faction: null, spawns: {} },
	};
	const items = {
		...base.items,
		95100: { id: 95100, name: 'Elite Tusk', drops: { npc: { 95003: 60 }, object: {} }, vendors: [] },
		95101: { id: 95101, name: 'Kobold Tusk', drops: { npc: { 95003: 60, 95002: 10 }, object: {} }, vendors: [] },
	};
	const quest = (id, title, area, objectives) => ({ ...base.quests[7], id, title, area, pre: [], objectives });
	const boss = (id, name) => [{ type: 'kill', id, count: 1, text: `${name} slain` }];
	const quests = {
		...base.quests,
		9600: quest(9600, 'Into the Hollow', 7001, boss(95040, 'Hollow Lord')),
		9601: quest(9601, 'The Fire Lord', 7002, boss(95041, 'Fire Lord')),
		9602: quest(9602, 'Rumours of the Hollow', 7001, [{ type: 'kill', id: 6, count: 2, text: 'Kobold Vermin slain' }]),
		9603: quest(9603, 'Hollow Relics', 7001, boss(95040, 'Hollow Lord')),
	};
	const instances = {
		areas: { 7001: { kind: 'dungeon', name: 'Hollow Deeps' }, 7002: { kind: 'raid', name: 'Molten Core' } },
		maps: { 9900: { kind: 'dungeon', name: 'Hollow Deeps' } },
	};
	return new Data({ quests, npcs, objects: base.objects, items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta, instances }, { dir: base.dir });
}

// The fixture data plus escort quests (docs/GUIDE_FORMAT.md, "Escort
// quests"), each given and taken back by Marshal McBride: 9700 says escort in
// its event objective and also has a kill; 9701 has no objectives and says it
// in its objective text (Forever's own escorts); 9702 is worded otherwise and
// marked `escort` (a corrections.json fix); 9703 says escort in an objective
// copied from another quest and is marked not one; 9704 is an event that is
// no escort.
function escortData() {
	const base = fixtureData();
	const quest = (id, title, objectives, more = {}) => ({ ...base.quests[7], id, title, pre: [], objectives, objectiveText: '', ...more });
	const quests = {
		...base.quests,
		9700: quest(9700, 'The Vineyard Walk', [{ type: 'event', id: null, count: null, text: 'Escort Brother Danil to the vineyard' }, { type: 'kill', id: 6, count: 3, text: 'Kobold Vermin slain' }]),
		9701: quest(9701, 'Out of the Abbey', [], { objectiveText: 'Escort Khelden Bremen out of the abbey, then tell Marshal McBride.' }),
		9702: quest(9702, 'To the Road', [{ type: 'event', id: null, count: null, text: 'Protect Dermot Johns until you reach the road' }], { escort: true }),
		9703: quest(9703, 'Lost Dermot', [{ type: 'event', id: null, count: null, text: 'Escort Dermot Johns to the road' }], { objectiveText: 'Find Dermot Johns.', escort: false }),
		9704: quest(9704, 'The Vigil', [{ type: 'event', id: null, count: null, text: 'Keep the vigil at the abbey' }]),
	};
	return new Data({ quests, npcs: base.npcs, objects: base.objects, items: base.items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta }, { dir: base.dir });
}

// Our pack's manifest (guides/pack.json).
function ourManifest() {
	return readManifest(OFFICIAL_DIR, { official: true }).manifest;
}

// Build compiled guides into a pack folder (named after the manifest's folder,
// in a temp dir removed at exit) -> { dir, files, scripts }: scripts are the
// files its TOC loads, absolute, in load order.
function writeTestPack(guides, data = fixtureData(), manifest = ourManifest()) {
	return writePackInto(tmpdir(), { guides, manifest, data });
}

module.exports = { FIXTURES, DATA_DIR, GUIDES_DIR, fixtureData, groupData, escortData, guideText, lineOf, compile, plain, ourManifest, writeTestPack };
