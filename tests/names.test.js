'use strict';
// `names build` (tools/lib/names/build.js): the IDs our compiled guides name,
// QuestieDB's localization blocks (a synthetic store encoded here: CBOR, zlib,
// base64, as QuestieDB's generator writes them), pfQuest's locale databases,
// the merge rules and the generated Polestar_Names addon; and the committed
// addon itself.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const { usedNames, readQuestieNames, mergeNames, buildNames, unescapeLua, LOCALES, ADDON } = require('../tools/lib/names/build');
const { SIZE_BUDGET } = require('../tools/commands/names');
const { runAddon, dirFiles, ROOT } = require('./helpers/lua');
const { tmpdir } = require('./helpers/tmp');

// --- a minimal CBOR encoder (C_EncodingUtil.SerializeCBOR's shapes) ---------

function head(major, n) {
	if (n < 24) return Buffer.from([(major << 5) | n]);
	if (n < 256) return Buffer.from([(major << 5) | 24, n]);
	if (n < 65536) return Buffer.from([(major << 5) | 25, n >> 8, n & 255]);
	const b = Buffer.alloc(5);
	b[0] = (major << 5) | 26;
	b.writeUInt32BE(n, 1);
	return b;
}

// Numbers (unsigned), strings (as byte strings, the way Lua strings encode),
// arrays, and Maps with integer keys (a Lua table with holes).
function cbor(v) {
	if (typeof v === 'number') return head(0, v);
	if (typeof v === 'string') {
		const b = Buffer.from(v, 'utf8');
		return Buffer.concat([head(2, b.length), b]);
	}
	if (Array.isArray(v)) return Buffer.concat([head(4, v.length), ...v.map(cbor)]);
	if (v instanceof Map) return Buffer.concat([head(5, v.size), ...[...v].flatMap(([k, x]) => [cbor(k), cbor(x)])]);
	throw new Error(`cbor: unsupported ${typeof v}`);
}

const packed = (v) => zlib.deflateSync(cbor(v)).toString('base64');

// A QuestieDB folder holding only what the names reader reads: the ID lists
// and the localization blocks. l10n: { locale: { Npc: { id: name }, Object: ... } }
function writeQuestie(dir, ids, l10n, { version = '1' } = {}) {
	const q = path.join(dir, 'QuestieDB');
	fs.mkdirSync(q, { recursive: true });
	const lines = ['## Interface: 16001', '## Title: QuestieDB', '## Version: 9.9.9', '## X-BUILD-COMMIT: abc123', `## X-l10n-Version: ${version}`];
	for (const e of ['Npc', 'Object']) lines.push(`## X-${e}-IDS: ${packed(ids[e])}`);
	for (const [locale, byEntity] of Object.entries(l10n)) {
		for (const [e, names] of Object.entries(byEntity)) {
			// Column 1 (names) by position in the ID list; holes make it a map.
			const column = new Map(ids[e].map((id, i) => [i + 1, names[id]]).filter(([, n]) => n !== undefined));
			const value = packed(new Map([[1, column]]));
			// Long values are split into parts, as the generator does.
			const half = Math.ceil(value.length / 2);
			lines.push(`## X-l10n-${locale}-${e}: ~2~`, `## X-l10n-${locale}-${e}-1: ${value.slice(0, half)}`, `## X-l10n-${locale}-${e}-2: ${value.slice(half)}`);
		}
	}
	fs.writeFileSync(path.join(q, 'QuestieDB_Forever.toc'), lines.join('\r\n') + '\r\n');
	return q;
}

// A pfQuest checkout with db/<locale>/units.lua and objects.lua.
function writePfQuest(dir, db) {
	const p = path.join(dir, 'pfQuest');
	fs.mkdirSync(p, { recursive: true });
	fs.writeFileSync(
		path.join(p, 'LICENSE'),
		'MIT License\n\nCopyright (c) 2017-2021 Fixture\n\nPermission is hereby granted, free of charge, to any person obtaining a copy.\n\nTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.\n',
	);
	for (const [locale, kinds] of Object.entries(db)) {
		fs.mkdirSync(path.join(p, 'db', locale), { recursive: true });
		for (const [kind, names] of Object.entries(kinds)) {
			const rows = Object.entries(names).map(([id, n]) => `  [${id}] = ${JSON.stringify(n)},`);
			fs.writeFileSync(path.join(p, 'db', locale, `${kind}.lua`), `pfDB["${kind}"]["${locale}"] = {\n${rows.join('\n')}\n}\n`);
		}
	}
	return p;
}

const GUIDES = [
	'{ t = "accept", quest = 6181, title = "A Swift Message", npc = 491, npcName = "Quartermaster Lewis", map = 1436, x = 57, y = 47 },',
	'{ t = "kill", quest = 9, title = "The Killing Fields", target = "Harvest Watcher", npc = 114, count = 20 },',
	'{ t = "interact", quest = 1140, title = "The Tower of Althalaxx", object = 20352, objName = "Circle of Imprisonment" },',
	'{ t = "talk", npc = 4792, npcName = "\\"Swamp Eye\\" Jarl" },',
	'{ t = "talk", npc = 2756, npcName = "Grund Drokda" },',
	'{ t = "talk", npc = 253092, npcName = "Alba Fairmoon" },',
	'candidates = { { npc = 523, npcName = "Thor", map = 1436, x = 56.55, y = 52.64 } },',
].join('\n');

test('usedNames: the NPCs and objects of goals, kill targets and candidates, with Lua escapes read back', () => {
	const used = usedNames([GUIDES]);
	assert.deepEqual([...used.npc.keys()].sort((a, b) => a - b), [114, 491, 523, 2756, 4792, 253092]);
	assert.deepEqual([...used.npc.get(114)], ['Harvest Watcher']);
	assert.deepEqual([...used.npc.get(4792)], ['"Swamp Eye" Jarl']);
	assert.deepEqual([...used.object.entries()].map(([id, s]) => [id, [...s]]), [[20352, ['Circle of Imprisonment']]]);
	assert.equal(unescapeLua('a\\\\b\\"c\\n\\009d'), 'a\\b"c\n\td');
});

test('mergeNames: QuestieDB first, pfQuest where its English is ours; a name like the English and an NPC renamed for Forever are left out', () => {
	const used = usedNames([GUIDES]);
	const m = (o) => new Map(Object.entries(o).map(([k, v]) => [Number(k), v]));
	const questie = { names: { frFR: { npc: m({ 491: 'Intendant Lewis', 523: 'Thor', 2756: 'Grund Drokda (FR)' }), object: m({}) } } };
	const pfquest = {
		en: { npc: m({ 491: 'Quartermaster Lewis', 114: 'Harvest Watcher', 4792: '"Swamp Eye" Jarl', 2756: 'UNUSED Grund Drokda' }), object: m({ 20352: 'Circle of Imprisonment' }) },
		names: { frFR: { npc: m({ 491: 'Lewis (pf)', 114: 'Gardien des moissons', 4792: 'Jarl "Oeil-des-marais"' }), object: m({ 20352: "Cercle d'emprisonnement" }) } },
	};
	const out = mergeNames(used, { questie, pfquest }, ['frFR', 'deDE']);
	assert.deepEqual(Object.keys(out), ['frFR'], 'a locale without a name is not built');
	assert.deepEqual(out.frFR.npc, [[114, 'Gardien des moissons'], [491, 'Intendant Lewis'], [4792, 'Jarl "Oeil-des-marais"']]);
	assert.deepEqual(out.frFR.object, [[20352, "Cercle d'emprisonnement"]]);
	// Thor is Thor in French; Grund Drokda's Era English differs from ours.
	assert.deepEqual(out.frFR.counts, { questie: 1, pfquest: 3, renamed: 1 });
});

test('readQuestieNames: localization blocks decoded by each id\'s position in the ID list, split values joined; another format refused', () => {
	const dir = tmpdir('polestar-names-q-');
	const ids = { Npc: [114, 491, 523, 253092], Object: [20352] };
	writeQuestie(dir, ids, { frFR: { Npc: { 114: 'Gardien des moissons', 491: 'Intendant Lewis' }, Object: { 20352: "Cercle d'emprisonnement" } }, deDE: { Npc: { 491: 'Rüstmeister Lewis' } } });
	const used = usedNames([GUIDES]);
	const got = readQuestieNames(dir, used, ['frFR', 'deDE', 'ruRU']);
	assert.deepEqual(got.info, { version: '9.9.9', commit: 'abc123' });
	assert.deepEqual([...got.names.frFR.npc].sort((x, y) => x[0] - y[0]), [[114, 'Gardien des moissons'], [491, 'Intendant Lewis']]);
	assert.deepEqual([...got.names.frFR.object], [[20352, "Cercle d'emprisonnement"]]);
	assert.deepEqual([...got.names.deDE.npc], [[491, 'Rüstmeister Lewis']]);
	assert.equal(got.names.ruRU.npc.size, 0);
	const other = tmpdir('polestar-names-q2-');
	writeQuestie(other, ids, {}, { version: '2' });
	assert.throws(() => readQuestieNames(other, used), /localization format 2, expected 1/);
	fs.rmSync(dir, { recursive: true, force: true });
	fs.rmSync(other, { recursive: true, force: true });
});

test('buildNames: one file per language, a TOC loading each only in its client, the notices; a language no longer built is removed', () => {
	const dir = tmpdir('polestar-names-b-');
	const guides = path.join(dir, 'Guides.lua');
	fs.writeFileSync(guides, GUIDES);
	const questieDir = writeQuestie(dir, { Npc: [114, 491], Object: [20352] }, { frFR: { Npc: { 491: 'Intendant Lewis' } } });
	const pfquestDir = writePfQuest(dir, {
		enUS: { units: { 114: 'Harvest Watcher', 491: 'Quartermaster Lewis' }, objects: { 20352: 'Circle of Imprisonment' } },
		frFR: { units: { 114: 'Gardien des moissons' }, objects: { 20352: "Cercle d'emprisonnement" } },
		deDE: { units: { 114: 'Erntewächter' }, objects: {} },
	});
	const outDir = path.join(dir, ADDON);
	fs.mkdirSync(outDir);
	fs.writeFileSync(path.join(outDir, 'ruRU.lua'), '-- stale');
	const res = buildNames({ questieDir, pfquestDir, inputs: [guides], outDir, version: '1.2.3' });
	assert.deepEqual(Object.keys(res.locales), ['deDE', 'frFR']);
	assert.deepEqual(res.locales.frFR, { npc: 2, object: 1, questie: 1, pfquest: 2, renamed: 0, bytes: res.locales.frFR.bytes });
	assert.deepEqual(fs.readdirSync(outDir).sort(), ['LICENSE-DATA.txt', 'Polestar_Names.toc', 'deDE.lua', 'frFR.lua']);
	const toc = fs.readFileSync(path.join(outDir, 'Polestar_Names.toc'), 'utf8');
	assert.match(toc, /^## Version: 1\.2\.3$/m);
	assert.match(toc, /^## LoadOnDemand: 1$/m);
	assert.match(toc, /^## X-Locales: deDE, frFR$/m);
	assert.match(toc, /^deDE\.lua \[AllowLoadTextLocale deDE\]\nfrFR\.lua \[AllowLoadTextLocale frFR\]$/m);
	const fr = fs.readFileSync(path.join(outDir, 'frFR.lua'), 'utf8');
	assert.match(fr, /^-- Generated by `node tools\/polestar\.js names build`/);
	assert.match(fr, /^if GetLocale\(\) ~= "frFR" then return end$/m);
	assert.match(fr, /^\[114\]="Gardien des moissons",\n\[491\]="Intendant Lewis",\n\}, \{\n\[20352\]="Cercle d'emprisonnement",\n\}\)$/m);
	const notice = fs.readFileSync(path.join(outDir, 'LICENSE-DATA.txt'), 'utf8');
	assert.match(notice, /^Revision: 9\.9\.9 abc123$/m);
	assert.match(notice, /^License: MIT$/m);
	assert.match(notice, /Copyright \(c\) 2017-2021 Fixture/);
	// The same inputs give the same files.
	const before = fs.readFileSync(path.join(outDir, 'frFR.lua'), 'utf8');
	buildNames({ questieDir, pfquestDir, inputs: [guides], outDir, version: '1.2.3' });
	assert.equal(fs.readFileSync(path.join(outDir, 'frFR.lua'), 'utf8'), before);
	fs.rmSync(dir, { recursive: true, force: true });
});

// --- the committed addon ---------------------------------------------------------

const PACK_DIR = path.join(ROOT, 'addon', ADDON);

test('the committed Polestar_Names: each language file registers only in its own client, within budget; X-Locales lists exactly the files', () => {
	const toc = fs.readFileSync(path.join(PACK_DIR, `${ADDON}.toc`), 'utf8');
	const locales = /^## X-Locales: (.*)$/m.exec(toc)[1].split(', ');
	assert.ok(locales.includes('frFR'));
	for (const l of locales) assert.ok(LOCALES.includes(l), l);
	assert.deepEqual(fs.readdirSync(PACK_DIR).filter((f) => f.endsWith('.lua')).sort(), locales.map((l) => `${l}.lua`).sort());
	for (const l of locales) {
		assert.match(toc, new RegExp(`^${l}\\.lua \\[AllowLoadTextLocale ${l}\\]$`, 'm'));
		assert.ok(fs.statSync(path.join(PACK_DIR, `${l}.lua`)).size <= SIZE_BUDGET, `${l}.lua within ${SIZE_BUDGET} bytes`);
	}
	const files = dirFiles(PACK_DIR);
	const [got] = runAddon({
		script: `
			local out = {}
			for _, client in ipairs({ ${[...locales, 'enUS'].map((l) => JSON.stringify(l)).join(', ')} }) do
				GetLocale = function() return client end
				local calls = {}
				Polestar = { LocalNames = { Register = function(locale, npcs, objects)
					local n = 0
					for _ in pairs(npcs) do n = n + 1 end
					calls[#calls + 1] = { locale = locale, npcs = n, lewis = npcs[491], circle = objects[20352] }
				end } }
				for _, f in ipairs({ ${files.map((f) => JSON.stringify(f)).join(', ')} }) do dofile(f) end
				out[client] = calls
			end
			emit(out)`,
	}).emitted;
	for (const l of locales) {
		assert.equal(got[l].length, 1, `${l}: one Register`);
		assert.equal(got[l][0].locale, l);
		assert.ok(got[l][0].npcs > 100, `${l}: names`);
	}
	assert.equal(Object.keys(got.enUS).length, 0, 'an English client registers nothing');
	assert.equal(got.frFR[0].lewis, 'Intendant Lewis');
	assert.equal(got.frFR[0].circle, "Cercle d'emprisonnement");
});
