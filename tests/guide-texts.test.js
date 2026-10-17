'use strict';
// A guide's texts in the client's language (docs/TRANSLATING.md, "Guide
// texts"; addon/Polestar/Core/GuideTexts.lua): the compiler writes the game's
// names inside the prose as {kind:id} tokens and drops a goal note that only
// names its goal (#133); an English client reads the guide as written; a
// French one reads the game's French names in it, and the pack's French
// texts, from its texts addon, where they are translated. `i18n guides`
// writes and checks the texts files a translator fills.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { namesPack } = require('./helpers/names');
const { tmpdir } = require('./helpers/tmp');
const { DATA_DIR } = require('./helpers/dsl');
const { polestar } = require('./helpers/cli');
const { buildPack } = require('../tools/lib/pack/build');
const { commandPack } = require('../tools/lib/pack/locate');
const { writePackDir } = require('../tools/lib/dsl/project');

const TIP = 'Marshal McBride stands at the abbey door; Brother Danil sells food inside. Kobold Vermin crowd the camp to the north.';
const GUIDE = `guide texts/main
title Elwynn Forest
faction Alliance
levels 1-10
zone Elwynn Forest
folder Warrior

step Marshal McBride
  tip ${TIP}
  accept 7 -- Marshal McBride
  kill 6 quest 7 -- a few Kobold Vermin at a time
  turnin 7 -- Marshal McBride; he also trains you
`;

// A pack folder with that guide, and its locales/ when `locales` ({ locale:
// { file: text } }) is given.
function packDir(locales = {}) {
	const dir = tmpdir('polestar-texts-');
	fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify({ id: 'texts', title: 'Texts Pack', author: 'Ann', version: '1.0.0', license: 'CC0-1.0', folder: 'PolestarPack_Texts' }));
	fs.mkdirSync(path.join(dir, 'guides'));
	fs.writeFileSync(path.join(dir, 'guides', 'main.guide'), GUIDE);
	for (const [locale, files] of Object.entries(locales)) {
		for (const [f, text] of Object.entries(files)) {
			const file = path.join(dir, 'locales', locale, f);
			fs.mkdirSync(path.dirname(file), { recursive: true });
			fs.writeFileSync(file, text);
		}
	}
	return dir;
}

function build(dir) {
	const r = buildPack({ ...commandPack({ pack: dir }), contextDir: null }, { dataDir: DATA_DIR });
	assert.deepEqual(r.diag.errors.map((d) => d.message), []);
	return r;
}

// The built pack (and texts addons) in a fresh AddOns folder.
function install(r) {
	const addons = tmpdir('polestar-texts-addons-');
	const out = path.join(addons, r.manifest.folder);
	writePackDir(out, r.files);
	return { addons, out };
}

// `node tools/polestar.js i18n guides ...` on the pack folder `dir`, with the fixture data.
const i18n = (args) => polestar(args);

const FR_NAMES = namesPack('frFR', { npc: { 197: 'Maréchal McBride', 152: 'Frère Danil', 6: 'Vermine kobold' }, quest: { 7: 'Nettoyer le camp des kobolds' } });

// The guide window's view of step 1 on a client in `locale`.
function view(addons, folder, { locale = 'enUS', names = null, texts = [], script = '' } = {}) {
	const packs = texts.map((name) => `stub.packs[${JSON.stringify(name)}] = { ${JSON.stringify(path.join(addons, name, 'Texts.lua'))} }`).join('\n');
	return runAddon({
		stubs: ['stub_world.lua', 'stub_packs.lua'],
		before: `function GetLocale() return ${JSON.stringify(locale)} end
LOCALIZED_CLASS_NAMES_MALE = { WARRIOR = ${JSON.stringify(locale === 'frFR' ? 'Guerrier' : 'Warrior')} }
do
	local load = loadfile
	function loadfile(file)
		if file:match("[/\\\\]Locales[/\\\\]%a%a%u%u%.lua$") then return function() end end
		return load(file)
	end
end
${names ? names.stubLua : ''}
${packs}
stub.world.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
stub.world.moveTo(1429, 48, 42)`,
		addons: ['Polestar', { name: folder, dir: path.join(addons, folder) }],
		script: `stub.login()
local E = Polestar.Engine
E.SetGuide("texts/main")
local v = E.GetStepView(1)
local notes = {}
for i, g in ipairs(v.goals) do notes[i] = g.note or false end
local h = Polestar.Guides.List()[1]
emit({ title = v.title, note = v.note, notes = notes, guide = h.title, folder = h.folder, pack = Polestar.Guides.Pack("texts").title })
${script}`,
	}).emitted;
}

test('the compiler writes the names it knows as tokens and drops a note that only names its goal', () => {
	const r = build(packDir());
	const g = r.guides[0]._localised;
	assert.equal(g.steps[0].title, '{npc:197}');
	assert.equal(g.steps[0].note, '{npc:197} stands at the abbey door; {npc:152} sells food inside. {npc:6} crowd the camp to the north.');
	assert.equal(g.title, '{zone:1429}');
	assert.deepEqual(g.steps[0].goals.map((x) => x.note || null), [null, 'a few {npc:6} at a time', '{npc:197}; he also trains you']);
	assert.equal(g.names['npc:197'], 'Marshal McBride');
	assert.equal(r.guides[0].steps[0].note, TIP, 'the compiled guide the other tools read keeps its English');
	assert.match(r.files['Guides.lua'], /names = \{ \["npc:152"\] = "Brother Danil", \["npc:197"\] = "Marshal McBride"/);
});

test('an English client reads the guide as its author wrote it, less the note that only named the giver', () => {
	const r = build(packDir());
	const { addons } = install(r);
	const [v] = view(addons, r.manifest.folder);
	assert.equal(v.title, 'Marshal McBride');
	assert.equal(v.note, TIP);
	assert.deepEqual(v.notes, [false, 'a few Kobold Vermin at a time', 'Marshal McBride; he also trains you']);
	assert.equal(v.guide, 'Elwynn Forest');
	assert.equal(v.folder, 'Warrior');
});

test("a French client reads the game's French names in the English texts until the pack translates them", () => {
	const r = build(packDir());
	const { addons } = install(r);
	assert.equal(fs.existsSync(path.join(addons, 'PolestarPack_Texts_frFR')), false, 'no translation, no texts addon');
	const [v] = view(addons, r.manifest.folder, { locale: 'frFR', names: FR_NAMES });
	assert.equal(v.title, 'Maréchal McBride');
	assert.equal(v.note, 'Maréchal McBride stands at the abbey door; Frère Danil sells food inside. Vermine kobold crowd the camp to the north.');
	assert.deepEqual(v.notes, [false, 'a few Vermine kobold at a time', 'Maréchal McBride; he also trains you']);
	assert.equal(v.folder, 'Guerrier', "a class folder is the client's class name");
});

const FR_TEXTS = {
	'guides/main.lua': `return {
	["{npc:197} stands at the abbey door; {npc:152} sells food inside. {npc:6} crowd the camp to the north."] = "{npc:197} se tient à la porte de l'abbaye ; {npc:152} vend à manger à l'intérieur. Au nord : {npc:6}.",
	["a few {npc:6} at a time"] = "quelques {npc:6} à la fois",
	["{npc:197}; he also trains you"] = "{npc:197} ; il vous entraîne aussi",
}
`,
	'_pack.lua': `return {
	["Texts Pack"] = "Pack de textes",
}
`,
};

test("the pack's French texts addon loads on a French client only, and its translations show with the French names", () => {
	const r = build(packDir({ frFR: FR_TEXTS }));
	const { addons } = install(r);
	const toc = fs.readFileSync(path.join(addons, 'PolestarPack_Texts_frFR', 'PolestarPack_Texts_frFR.toc'), 'utf8');
	assert.match(toc, /^## LoadOnDemand: 1$/m);
	assert.match(toc, /^## X-Polestar-Texts: texts$/m);
	const [fr] = view(addons, r.manifest.folder, { locale: 'frFR', names: FR_NAMES, texts: ['PolestarPack_Texts_frFR'], script: 'emit(stub.packLoads)' });
	assert.equal(fr.note, "Maréchal McBride se tient à la porte de l'abbaye ; Frère Danil vend à manger à l'intérieur. Au nord : Vermine kobold.");
	assert.deepEqual(fr.notes, [false, 'quelques Vermine kobold à la fois', 'Maréchal McBride ; il vous entraîne aussi']);
	assert.equal(fr.pack, 'Pack de textes');
	const [de, loads] = view(addons, r.manifest.folder, { locale: 'deDE', texts: ['PolestarPack_Texts_frFR'], script: 'emit(stub.packLoads)' });
	assert.equal(de.note, TIP, 'a German client reads the English');
	assert.deepEqual(loads, {}, 'and never loads the French texts');
});

test('i18n guides sync writes every text to translate with its names shown; check fails on a lost token and names the new English of a stale one', () => {
	const dir = packDir();
	const sync = i18n(['i18n', 'guides', 'sync', 'frFR', '--pack', dir, '--data', DATA_DIR]);
	assert.equal(sync.status, 0, sync.stderr);
	const file = path.join(dir, 'locales', 'frFR', 'guides', 'main.lua');
	const text = fs.readFileSync(file, 'utf8');
	assert.match(text, /-- \{npc:197\} Marshal McBride · \{npc:152\} Brother Danil · \{npc:6\} Kobold Vermin\n/);
	assert.match(text, /\["a few \{npc:6\} at a time"\] = "",/);
	assert.doesNotMatch(text, /\["\{npc:197\}"\]/, 'a text that is only a name needs no words');
	fs.writeFileSync(file, text.replace('["a few {npc:6} at a time"] = ""', '["a few {npc:6} at a time"] = "quelques-uns à la fois"'));
	const lost = i18n(['i18n', 'guides', 'check', 'frFR', '--pack', dir, '--data', DATA_DIR]);
	assert.equal(lost.status, 1);
	assert.match(lost.stderr, /leaves out \{npc:6\}/);
	fs.writeFileSync(file, fs.readFileSync(file, 'utf8').replace('"quelques-uns à la fois"', '"quelques {npc:6} à la fois"'));
	fs.writeFileSync(path.join(dir, 'guides', 'main.guide'), GUIDE.replace('-- a few Kobold Vermin at a time', '-- a few Kobold Vermin at once'));
	const stale = i18n(['i18n', 'guides', 'check', 'frFR', '--pack', dir, '--data', DATA_DIR]);
	assert.equal(stale.status, 1);
	assert.match(stale.stderr, /stale translation of "a few \{npc:6\} at a time" \(its English is now "a few \{npc:6\} at once"/);
	const again = i18n(['i18n', 'guides', 'sync', 'frFR', '--pack', dir, '--data', DATA_DIR]);
	assert.equal(again.status, 0, again.stderr);
	assert.match(fs.readFileSync(file, 'utf8'), /-- \["a few \{npc:6\} at a time"\] = "quelques \{npc:6\} à la fois",/, 'the old translation waits, commented out, for its translator');
	const clean = i18n(['i18n', 'guides', 'check', 'frFR', '--pack', dir, '--data', DATA_DIR]);
	assert.equal(clean.status, 0, clean.stderr);
});

test('a token the author wrote must name something the data has', () => {
	const dir = packDir();
	fs.writeFileSync(path.join(dir, 'guides', 'main.guide'), GUIDE.replace('tip Marshal', 'tip Ask {npc:999999} or Marshal'));
	const r = buildPack({ ...commandPack({ pack: dir }), contextDir: null }, { dataDir: DATA_DIR });
	assert.deepEqual(r.diag.errors.map((d) => d.message), ['{npc:999999}: the data has no npc 999999']);
});

test('a name written without the game\'s "The" keeps the author\'s words in English', () => {
	const dir = packDir();
	fs.writeFileSync(path.join(dir, 'guides', 'main.guide'), GUIDE.replace(`tip ${TIP}`, 'tip Ride to Stormwind; ask Marshal McBride.'));
	const r = build(dir);
	const g = r.guides[0]._localised;
	const { fillTokens } = require('../tools/lib/dsl/tokens');
	assert.equal(g.steps[0].note, 'Ride to {zone:1453}; ask {npc:197}.');
	assert.equal(fillTokens(g.steps[0].note, g.names), 'Ride to Stormwind; ask Marshal McBride.');
});

test("an NPC of the step named by its first name is its token, and an English client still reads the author's words", () => {
	const dir = packDir();
	fs.writeFileSync(path.join(dir, 'guides', 'main.guide'), GUIDE.replace(`tip ${TIP}`, 'tip Marshal McBride stands at the abbey door. Ask Marshal again later.'));
	const r = build(dir);
	const g = r.guides[0]._localised;
	assert.equal(g.steps[0].note, '{npc:197} stands at the abbey door. Ask {npc:197} again later.');
	const { addons } = install(r);
	assert.equal(view(addons, r.manifest.folder)[0].note, 'Marshal McBride stands at the abbey door. Ask Marshal again later.');
	assert.equal(view(addons, r.manifest.folder, { locale: 'frFR', names: FR_NAMES })[0].note, "Maréchal McBride stands at the abbey door. Ask Maréchal McBride again later.");
});

test('a translation may write as words an object no source names in its language', () => {
	const { textProblems } = require('../tools/lib/i18n/guides');
	assert.deepEqual(textProblems('Meet him in the {object:2101}.', 'Retrouvez-le dans le Quartier des mages.', [], ['object:2101']), []);
	assert.match(textProblems('Meet him in the {object:2101}.', 'Retrouvez-le dans le Quartier des mages.')[0], /leaves out \{object:2101\}/);
});

test('a name inside a longer proper name the data lacks stays words', () => {
	const dir = packDir();
	fs.writeFileSync(path.join(dir, 'guides', 'main.guide'), GUIDE.replace(`tip ${TIP}`, 'tip Young Kobold Vermin Runts sit by Marshal McBride; Kobold Vermin Chiefs too, and Kobold Vermin.'));
	const r = build(dir);
	assert.equal(r.guides[0]._localised.steps[0].note, 'Young Kobold Vermin Runts sit by {npc:197}; Kobold Vermin Chiefs too, and {npc:6}.');
});

test('a translation may name a plural the English keeps as words by its singular token', () => {
	const { textProblems } = require('../tools/lib/i18n/guides');
	assert.deepEqual(textProblems('Kill the Kobold Vermins.', 'Bandidos ({npc:6}) ×8', ['npc:6']), []);
	assert.match(textProblems('Kill the Kobold Vermins.', 'Bandidos ({npc:6})')[0], /has \{npc:6\}/);
});
