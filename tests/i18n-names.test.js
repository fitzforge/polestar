'use strict';
// The names addons (`i18n names`, tools/lib/i18n/names.js) on fixture
// sources (tests/fixtures/names): DingDB's names first and pfQuest's for the
// ones it lacks, only the ids Polestar's data names (compiled guides, the
// quest database, the Codex), DingDB pinned to a commit and its files'
// sha256s, and --no-questie leaving DingDB out. The written addon loads in
// Lua 5.1 and gives the names back.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const { spawnSync } = require('node:child_process');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { polestar } = require('./helpers/cli');
const { runAddon } = require('./helpers/lua');
const { LOCALE_CODES } = require('../tools/lib/i18n/locales');
const names = require('../tools/lib/i18n/names');
const { loadPfQuestNames } = require('../tools/lib/data/pfquest');

const FIX = path.join(__dirname, 'fixtures', 'names');
const DING = path.join(FIX, 'ding');
const PF = path.join(FIX, 'pfquest');
const INPUTS = { guides: path.join(FIX, 'Guides.lua'), questdb: path.join(FIX, 'questdb'), codex: path.join(FIX, 'codex') };
const VERSION = require('../package.json').version;

const sha = (file) => crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
const DING_FILES = ['Ding/DB/CREDITS.md', 'Ding/DB/Locales/deDE.lua', 'Ding/DB/Locales/esMX.lua', 'Ding/DB/Locales/frFR.lua'];
function fixturePin(dir = DING) {
	const files = {};
	for (const f of DING_FILES) files[f] = sha(path.join(dir, f));
	return { repo: 'https://example.invalid/ding', version: 'v0.0.0', commit: 'a'.repeat(40), files };
}
const obj = (m) => Object.fromEntries([...m].map(([k, v]) => [k, v]));

function build({ ding = true, locales = LOCALE_CODES } = {}) {
	const ids = names.usedIds(INPUTS);
	const d = ding ? names.ensureDing({ dir: DING, explicit: true, pin: fixturePin() }) : null;
	const pf = loadPfQuestNames(PF, [...locales, 'enUS']);
	return names.buildNames({ locales, ids, ding: d ? names.readDing(d, locales) : null, pf });
}

test('the ids kept are the ones the compiled guides (their goals and their texts\' tokens), the quest database and the Codex name', () => {
	const ids = names.usedIds(INPUTS);
	const sorted = (s) => [...s].sort((a, b) => a - b);
	assert.deepEqual(sorted(ids.quest), [7, 33, 34, 35, 176], 'goal quests, pre, closedBy and preTitles, QuestDB and Codex quests');
	assert.deepEqual(sorted(ids.npc), [6, 197, 240, 299, 448], 'goal and candidate NPCs, the names its texts show as tokens, QuestDB and Codex NPCs');
	assert.deepEqual(sorted(ids.object), [68, 2843]);
	assert.deepEqual(sorted(ids.item), [750, 1528, 2862], 'goal items, the guide reward, QuestDB and Codex items');
	assert.deepEqual(ids.counts.guides, { quest: 4, npc: 4, object: 1, item: 3 });
	assert.throws(() => names.usedIds({ ...INPUTS, questdb: path.join(FIX, 'nowhere') }), /questdb build.*--questdb/s, 'a missing input says how to get it');
});

test('DingDB names come first and pfQuest fills the gaps; a pfQuest name that is its English one is no translation; nothing outside the ids', () => {
	const out = build();
	const fr = out.frFR;
	assert.deepEqual(obj(fr.names.quest), { 7: 'Nettoyer le camp des kobolds', 33: 'Les loups à la frontière', 176: 'Avis de recherche : "Lardeur"' });
	assert.deepEqual(obj(fr.names.npc), { 6: 'Vermine kobold', 240: 'Maréchal Dughan', 448: 'Lardeur' }, 'Ding over pfQuest for 448; 197 is English in pfQuest; 99999 unused');
	assert.deepEqual(obj(fr.names.object), { 68: 'Avis de recherche', 2843: 'Coffre cabossé' });
	assert.deepEqual(obj(fr.names.item), { 750: 'Viande de loup coriace', 1528: "Poignée d'avoine", 2862: 'Pierre à aiguiser brute' });
	assert.deepEqual(Object.fromEntries(names.NAME_KINDS.map((k) => [k, fr.from[k]])), {
		quest: { wago: 0, wowhead: 0, ding: 2, pfquest: 1 }, npc: { wago: 0, wowhead: 0, ding: 2, pfquest: 1 },
		object: { wago: 0, wowhead: 0, ding: 1, pfquest: 1 }, item: { wago: 0, wowhead: 0, ding: 2, pfquest: 1 },
	});
	assert.deepEqual(obj(out.esMX.names.npc), { 240: 'Alguacil Dughan' }, 'pfQuest has no esMX: DingDB only; its "Hogger", the English name, is not stored');
	assert.deepEqual(obj(out.deDE.names.npc), { 6: 'Koboldungeziefer' });
	assert.equal(out.koKR.names.npc.size, 0, 'a locale neither source has stays empty');
	assert.deepEqual([...fr.names.npc.keys()], [6, 240, 448], 'sorted by id');
});

test('DingDB is pinned: a file that differs from the pin, or a checkout at another commit, stops the build', () => {
	const ok = names.ensureDing({ dir: DING, explicit: true, pin: fixturePin() });
	assert.equal(ok.revision, null, 'a fixture folder is not a git checkout');
	assert.deepEqual(ok.files.map((f) => f.path), DING_FILES);
	const dir = tmpdir();
	fs.cpSync(DING, dir, { recursive: true });
	const pin = fixturePin(dir);
	fs.appendFileSync(path.join(dir, 'Ding/DB/Locales/frFR.lua'), '-- edited\n');
	assert.throws(() => names.ensureDing({ dir, explicit: true, pin }), (e) => /Ding\/DB\/Locales\/frFR\.lua/.test(e.message) && e.message.includes(pin.files['Ding/DB/Locales/frFR.lua']));
	assert.throws(() => names.ensureDing({ dir: path.join(dir, 'missing'), explicit: true, pin }), /no Ding\/DB/);
	assert.throws(() => names.ensureDing({ dir: path.join(dir, 'missing'), offline: true, pin }), /--offline/);

	// A checkout at a commit other than the pin's: named, it stops; the cache
	// clone is moved to the pinned commit (here one it holds).
	const repo = tmpdir();
	fs.cpSync(DING, repo, { recursive: true });
	const g = (...args) => spawnSync('git', ['-c', 'user.name=t', '-c', 'user.email=t@t', ...args], { cwd: repo, encoding: 'utf8' });
	g('init', '--quiet');
	g('add', '.');
	g('commit', '--quiet', '-m', 'pinned');
	const pinned = g('rev-parse', 'HEAD').stdout.trim();
	fs.writeFileSync(path.join(repo, 'NEWS'), 'later\n');
	g('add', '.');
	g('commit', '--quiet', '-m', 'later');
	const repoPin = { ...fixturePin(repo), commit: pinned };
	assert.throws(() => names.ensureDing({ dir: repo, explicit: true, pin: repoPin }), new RegExp(`is at [0-9a-f]{40}, the pin is ${pinned}`));
	assert.equal(names.ensureDing({ dir: repo, offline: true, pin: repoPin }).revision, pinned, 'the cache clone checks out the pin');

	// The real pin: one commit, and a hash for the credits and each language.
	assert.match(names.DING.commit, /^[0-9a-f]{40}$/);
	assert.deepEqual(Object.keys(names.DING.files).sort(), ['Ding/DB/CREDITS.md', ...LOCALE_CODES.map((l) => `Ding/DB/Locales/${l}.lua`)].sort());
	for (const h of Object.values(names.DING.files)) assert.match(h, /^[0-9a-f]{64}$/);
});

test('the written addon: LoD toc, Names.lua that Lua 5.1 loads into Polestar.Names.Add, LICENSE-DATA with the pin, Ding\'s CREDITS.md', () => {
	const ding = names.ensureDing({ dir: DING, explicit: true, pin: fixturePin() });
	const pf = { dir: PF, revision: 'b'.repeat(40) };
	const out = build();
	const files = names.emitNamesAddon('frFR', out.frFR, { sources: { ding, pin: fixturePin(), pf } });
	assert.deepEqual(Object.keys(files).sort(), ['CREDITS.md', 'LICENSE-DATA.txt', 'Names.lua', 'Polestar_Names_frFR.toc']);
	const toc = files['Polestar_Names_frFR.toc'];
	assert.match(toc, /^## LoadOnDemand: 1$/m);
	assert.match(toc, /^## Dependencies: Polestar$/m);
	assert.match(toc, new RegExp(`^## Version: ${VERSION.replace(/\./g, '\\.')}$`, 'm'));
	assert.match(toc, /^Names\.lua$/m);
	assert.equal(files['CREDITS.md'], fs.readFileSync(path.join(DING, 'Ding/DB/CREDITS.md'), 'utf8'));
	const lic = files['LICENSE-DATA.txt'];
	assert.ok(lic.includes('a'.repeat(40)), 'the DingDB commit');
	assert.ok(lic.includes(fixturePin().files['Ding/DB/Locales/frFR.lua']), 'the frFR file sha256');
	assert.ok(lic.includes('b'.repeat(40)), 'the pfQuest revision');
	assert.match(lic, /GPL-3\.0/);
	assert.match(lic, /MIT License/);

	const dir = tmpdir();
	fs.writeFileSync(path.join(dir, 'Names.lua'), files['Names.lua']);
	const [got] = runAddon({
		script: `
Polestar = { Names = { got = {} } }
function Polestar.Names.Add(locale, kind, t)
	for id, name in pairs(t) do Polestar.Names.got[#Polestar.Names.got + 1] = locale .. " " .. kind .. " " .. id .. " " .. name end
end
dofile(${JSON.stringify(path.join(dir, 'Names.lua'))})
table.sort(Polestar.Names.got)
emit(Polestar.Names.got)`,
	}).emitted;
	assert.ok(got.includes('frFR npc 448 Lardeur'));
	assert.ok(got.includes('frFR quest 176 Avis de recherche : "Lardeur"'));
	assert.ok(got.includes("frFR item 1528 Poignée d'avoine"));
	assert.equal(got.length, 11);
});

test('--no-questie: pfQuest only, no DingDB credit; a language left without names gets no folder and loses a stale one', () => {
	const out = build({ ding: false });
	assert.deepEqual(obj(out.frFR.names.npc), { 6: 'Vermine kobold', 448: 'Lardeur (pfQuest)' });
	assert.deepEqual(obj(out.frFR.names.quest), { 7: 'Nettoyer le camp des kobolds', 176: 'Avis de recherche (pfQuest)' });
	assert.equal(out.esMX.names.npc.size, 0);

	const addons = tmpdir();
	fs.mkdirSync(path.join(addons, 'Polestar_Names_esMX'));
	fs.writeFileSync(path.join(addons, 'Polestar_Names_esMX', 'Names.lua'), '-- stale\n');
	const written = names.writeNamesAddons(out, addons, { sources: { ding: null, pf: { dir: PF, revision: null } } });
	assert.deepEqual(written.map((w) => w.locale), ['deDE', 'frFR']);
	assert.ok(!fs.existsSync(path.join(addons, 'Polestar_Names_esMX')), 'the stale folder is gone');
	assert.ok(!fs.existsSync(path.join(addons, 'Polestar_Names_frFR', 'CREDITS.md')));
	// Nothing DingDB alone holds reaches a written file: not its names, not its pin.
	const dingOnly = ['Maréchal Dughan', 'Les loups à la frontière', 'Viande de loup coriace', 'Alguacil Dughan', ...Object.values(fixturePin().files)];
	for (const dir of fs.readdirSync(addons)) {
		for (const f of fs.readdirSync(path.join(addons, dir))) {
			const text = fs.readFileSync(path.join(addons, dir, f), 'utf8');
			for (const d of dingOnly) assert.ok(!text.includes(d), `${dir}/${f} holds ${d}`);
		}
	}
});

test('node tools/polestar.js i18n names writes the folders and reports what each language has', () => {
	const out = tmpdir();
	const args = ['i18n', 'names', '--json', '--offline', '--sources', tmpdir(), '--no-questie', '--pfquest', PF, '--guides', INPUTS.guides, '--questdb', INPUTS.questdb, '--codex', INPUTS.codex, '--out', out];
	// --offline with an empty cache: no client tables stops the build, nothing written...
	const missing = polestar(args);
	assert.notEqual(missing.status, 0);
	assert.match(missing.stderr, /no forever client tables/);
	assert.deepEqual(fs.readdirSync(out), []);
	// ...unless they are left out on purpose.
	const r = polestar([...args, '--no-tables']);
	assert.equal(r.status, 0, r.stderr);
	const report = JSON.parse(r.stdout);
	assert.equal(report.ding, null);
	assert.equal(report.wago, null);
	assert.equal(report.wowhead, null, 'no Wowhead cache: nothing from it, nothing asked for');
	assert.deepEqual(Object.fromEntries(names.NAME_KINDS.map((k) => [k, report.locales.frFR.names[k]])), { quest: 2, npc: 2, object: 1, item: 1 });
	assert.deepEqual([report.locales.frFR.sameAsEnglish.npc, report.locales.frFR.lacking.npc], [1, report.ids.npc - 3],
		'what each language lacks, apart from Marshal McBride, whose only French name is the English one');
	assert.deepEqual(fs.readdirSync(out).sort(), ['Polestar_Names_deDE', 'Polestar_Names_frFR']);
	const lua = fs.readFileSync(path.join(out, 'Polestar_Names_frFR', 'Names.lua'), 'utf8');
	assert.ok(lua.includes('[448]="Lardeur (pfQuest)"'), 'the pfQuest name, written for the addon');
	const bad = polestar(['i18n', 'names', 'xxXX', '--no-questie', '--pfquest', PF]);
	assert.notEqual(bad.status, 0);
});

test('the release zip and install take every names addon that is built, after the Codex; the nine are committed', () => {
	const { releaseAddons } = require('../tools/lib/dsl/project');
	const { fakeAddons } = require('./helpers/cli');
	const { ADDONS } = require('./helpers/lua');
	const dir = fakeAddons(tmpdir(), ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_Codex', 'Polestar_Names_frFR']);
	const r = releaseAddons(dir);
	assert.deepEqual(r.names, ['Polestar', 'Polestar_Guides', 'Polestar_Nav', 'Polestar_Codex', 'Polestar_Names_frFR']);
	assert.ok(r.skipped.includes('Polestar_Names_deDE'), 'one not built is left out');
	const shipped = releaseAddons(ADDONS).names.filter((n) => n.startsWith(names.ADDON_PREFIX));
	assert.deepEqual(shipped, LOCALE_CODES.map((l) => `${names.ADDON_PREFIX}${l}`));
});
