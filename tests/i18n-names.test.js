'use strict';
// What the JS tools keep of the names addons (`forge data names` builds them:
// rust/crates/forge-data/tests/data/names.rs tests the builder): usedIds,
// the ids Polestar's data names, and the release taking every names addon.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { LOCALE_CODES } = require('../tools/lib/i18n/locales');
const names = require('../tools/lib/i18n/names');

const FIX = path.join(__dirname, 'fixtures', 'names');
const INPUTS = { guides: path.join(FIX, 'Guides.lua'), questdb: path.join(FIX, 'questdb'), codex: path.join(FIX, 'codex') };

test('the ids kept are the ones the compiled guides (their goals and their texts\' tokens), the quest database and the Codex name', () => {
	const ids = names.usedIds(INPUTS);
	const sorted = (s) => [...s].sort((a, b) => a - b);
	assert.deepEqual(sorted(ids.quest), [7, 33, 34, 35, 176], 'goal quests, pre, closedBy and preTitles, QuestDB and Codex quests');
	assert.deepEqual(sorted(ids.npc), [6, 197, 240, 299, 448], 'goal and candidate NPCs, the names its texts show as tokens, QuestDB and Codex NPCs');
	assert.deepEqual(sorted(ids.object), [68, 2843]);
	assert.deepEqual(sorted(ids.item), [750, 1528, 2862], 'goal items, the guide reward, QuestDB and Codex items');
	assert.deepEqual(ids.counts.guides, { quest: 4, npc: 4, object: 1, item: 3 });
	assert.throws(() => names.usedIds({ ...INPUTS, questdb: path.join(FIX, 'nowhere') }), /forge data questdb.*--questdb/s, 'a missing input says how to get it');
});

test('the release zip and install take every language folder that is built, after the Codex; the nine are committed, the old folders never ship', () => {
	const { releaseAddons } = require('../tools/lib/dsl/project');
	const { languageAddon } = require('../tools/lib/i18n/toc');
	const { fakeAddons } = require('./helpers/cli');
	const { ADDONS } = require('./helpers/lua');
	const dir = fakeAddons(tmpdir(), ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_FreeMode', 'Polestar_Options', 'Polestar_Codex', 'Polestar_frFR', 'Polestar_Names_deDE', 'Polestar_Guides_deDE']);
	const r = releaseAddons(dir);
	assert.deepEqual(r.names, ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_FreeMode', 'Polestar_Options', 'Polestar_Codex', 'Polestar_frFR']);
	assert.ok(r.skipped.includes('Polestar_deDE'), 'one not built is left out');
	const languages = LOCALE_CODES.map(languageAddon);
	const shipped = releaseAddons(ADDONS).names.filter((n) => languages.includes(n));
	assert.deepEqual(shipped, languages);
});

// #4045 (Riverglades, zhCN): a translation that writes an NPC's name as words (the sync's
// "-- plural, as words: <plural> = {npc:N} <name>" hint) uses the game's own name for that NPC in
// that language; "暮光掠夺者" is another NPC (Twilight Marauder), the game's Twilight Raider is
// "暮光袭击者". Languages without inflection only: the name is written as the game writes it.
// KNOWN: lines written before this check, each with the NPC's name in its own words; the list only
// shrinks (a line fixed here leaves it).
const NAMED_AS_IN_GAME_KNOWN = {
	zhCN: {
		'forever/alliance/02-westfall.lua': [157, 263389, 263390],
		'forever/alliance/03-darkshore-return.lua': [2237],
		'forever/alliance/04-redridge-mountains.lua': [445, 505],
		'forever/alliance/30-40/04-stranglethorn-vale.lua': [1150],
		'forever/alliance/30-40/05-arathi-highlands.lua': [247001, 247003, 254797],
		'forever/alliance/30-40/06-badlands.lua': [4846, 4872],
		'forever/alliance/30-40/06b-desolace.lua': [11560, 253272],
		'forever/alliance/50-60/03-winterspring.lua': [6519],
		'forever/alliance/human/01-elwynn-forest.lua': [735],
		'forever/alliance/nightelf/01-teldrassil.lua': [272096],
		'forever/horde/05-stonetalon-mountains.lua': [254294],
		'forever/horde/06-hillsbrad-foothills.lua': [4054],
		'forever/horde/07-ashenvale.lua': [4054, 4110, 7404],
		'forever/horde/30-40/02-thousand-needles.lua': [11562],
		'forever/horde/30-40/06-badlands.lua': [4846, 4872],
		'forever/horde/40-50/01-stranglethorn-vale.lua': [1557],
		'forever/horde/50-60/03-winterspring.lua': [7451],
		'forever/horde/50-60/05-eastern-plaguelands.lua': [10408, 11064],
		'forever/horde/skyborne/01-zephras-isle.lua': [251676],
		'forever/horde/tauren/01-mulgore.lua': [3131],
		'forever/reputation/stormwind.lua': [118],
		'forever/reputation/thunder-bluff.lua': [264096],
	},
};

test('a guide translation names an NPC as the game does in that language (#4045)', () => {
	const fs = require('node:fs');
	const root = path.join(__dirname, '..');
	for (const [loc, known] of Object.entries(NAMED_AS_IN_GAME_KNOWN)) {
		// addon/Polestar_<loc>/Names.lua: R("npc", lo, hi, [[ "<id>\t<name>" lines ]]), %XX escapes.
		const npcs = new Map();
		let kind = null;
		for (const line of fs.readFileSync(path.join(root, 'addon', `Polestar_${loc}`, 'Names.lua'), 'utf8').split('\n')) {
			const chunk = line.match(/^R\("(\w+)"/);
			if (chunk) kind = chunk[1];
			const row = line.match(/^(\d+)\t(.+)$/);
			if (row && kind === 'npc') npcs.set(Number(row[1]), row[2].replace(/%([0-9A-F]{2})/g, (_, h) => String.fromCharCode(parseInt(h, 16))));
		}
		const dir = path.join(root, 'guides', 'locales', loc);
		const walk = (d) => fs.readdirSync(d, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? walk(path.join(d, e.name)) : e.name.endsWith('.lua') ? [path.join(d, e.name)] : []));
		const offenders = [];
		const stillKnown = new Set();
		for (const file of walk(dir)) {
			const rel = path.relative(dir, file).split(path.sep).join('/');
			let hints = [];
			for (const line of fs.readFileSync(file, 'utf8').split('\n')) {
				const hint = line.match(/^\s*-- plural, as words: (.+)$/);
				if (hint) {
					for (const m of hint[1].matchAll(/\{npc:(\d+)\}/g)) hints.push(Number(m[1]));
					continue;
				}
				if (/^\s*--/.test(line)) continue;
				const tr = line.match(/^\s*\[".*"\] = "(.*)",?$/);
				if (!tr) continue;
				for (const id of tr[1] ? hints : []) {
					const name = npcs.get(id);
					if (!name || tr[1].includes(name) || tr[1].includes(`{npc:${id}}`)) continue;
					if ((known[rel] || []).includes(id)) stillKnown.add(`${rel}:${id}`);
					else offenders.push(`${loc} ${rel}: {npc:${id}} is "${name}" in the game`);
				}
				hints = [];
			}
		}
		assert.deepEqual(offenders, [], `${loc}: translations naming an NPC otherwise than the game`);
		const fixed = Object.entries(known).flatMap(([rel, ids]) => ids.map((id) => `${rel}:${id}`)).filter((k) => !stillKnown.has(k));
		assert.deepEqual(fixed, [], `${loc}: fixed since, take them off the known list`);
	}
});
