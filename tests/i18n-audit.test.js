'use strict';
// `i18n audit` (tools/lib/i18n/audit.js): a text whose English names a spell,
// a talent, an area or a talent tree carries the client's name for it. The
// client tables here are a few rows in the cache's layout, no download.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const fs = require('node:fs');
const { tmpdir } = require('./helpers/tmp');
const { spawnSync } = require('node:child_process');
const { readTexts, luaFiles, nameIndex, treeIndex, auditTexts, formatTable } = require('../tools/lib/i18n/audit');
const { loadAuditNames } = require('../tools/lib/i18n/names-wago');

const m = (o) => new Map(Object.entries(o).map(([k, v]) => [Number(k), v]));
const english = {
	spell: m({ 1: 'Mortal Strike', 2: 'Fire', 3: 'Holy Shock', 4: 'Smite', 5: 'Ratchet Bolt', 6: 'Holy Specialization' }),
	area: m({ 10: 'Deeprun Tram', 11: 'Ratchet Docks' }),
	skill: m({ 20: 'Subtlety', 21: 'Holy', 22: 'Shadow Magic', 23: 'Feral Combat', 24: 'Pet - Wolf' }),
	tree: m({ 20: 'Subtlety', 21: 'Holy', 22: 'Shadow Magic', 23: 'Feral Combat', 24: 'Pet - Wolf' }),
};
const names = {
	spell: m({ 1: 'Tödlicher Stoß', 2: 'Feuer', 3: 'Heiliger Schock', 4: 'Göttliche Pein', 5: 'Ratchet Bolt', 6: 'Heiligspezialisierung' }),
	area: m({ 10: 'Die Tiefenbahn', 11: 'Ratchet Docks' }),
	skill: m({ 20: 'Feingefühl', 21: 'Heilig', 22: 'Schattenmagie', 23: 'Wilder Kampf', 24: 'Tier - Wolf' }),
	tree: m({ 20: 'Feingefühl', 21: 'Heilig', 22: 'Schattenmagie', 23: 'Wilder Kampf', 24: 'Tier - Wolf' }),
};
const index = nameIndex({ names, english });
const trees = treeIndex({ names, english });
const audit = (en, tr) => auditTexts({ texts: [{ file: 'f.lua', line: 7, en, tr }], index, trees });

test('a name of several words must stand in the translation, in any case and with other endings', () => {
	assert.equal(audit('Use Mortal Strike on the boss', 'Benutze Tödlicher Stoß beim Boss').length, 0);
	assert.equal(audit('Use Holy Shock on the boss', 'Nutze den Heiligen Schock beim Boss').length, 0, 'inflected: Heiliger -> Heiligen');
	const [row] = audit('Use Mortal Strike on the boss', 'Benutze Mortal Strike beim Boss');
	assert.deepEqual({ kind: row.kind, en: row.en, client: row.client, file: row.file, line: row.line }, { kind: 'spell', en: 'Mortal Strike', client: ['Tödlicher Stoß'], file: 'f.lua', line: 7 });
});

test('hyphens and spaces of the translation do not matter: a compound the client writes in one word may be hyphenated', () => {
	assert.equal(audit('Holy Specialization first', 'Zuerst Heiligspezialisierung').length, 0);
	assert.equal(audit('Holy Specialization first', 'Zuerst Heilig-Spezialisierung').length, 0);
	assert.equal(audit('Holy Specialization first', 'Zuerst Heilig Spezialisierung').length, 0);
	assert.equal(audit('Holy Specialization first', 'Zuerst Göttliche Fertigkeit').length, 1);
});

test('names of a language with no spaces: a name of four characters or fewer is needed whole, a longer one by its first four', () => {
	const zh = nameIndex({ english: { spell: m({ 1: 'Flame Shock', 2: "Templar's Bulwark" }) }, names: { spell: m({ 1: '烈焰震击', 2: '圣殿骑士壁垒' }) } });
	const run = (en, tr) => auditTexts({ texts: [{ file: 'zh.lua', line: 1, en, tr }], index: zh });
	assert.equal(run('Use Flame Shock on it', '对它使用烈焰震击').length, 0);
	assert.equal(run('Use Flame Shock on it', '对它使用火焰冲击').length, 1);
	assert.equal(run("Templar's Bulwark is an absorb", '圣殿骑士壁垒是吸收').length, 0);
	assert.equal(run("Templar's Bulwark is an absorb", '圣殿壁垒是吸收').length, 1, 'the first four characters 圣殿骑士 are missing');
});

test('the findings are a table: a header, aligned columns, the English text cut at 60 characters', () => {
	const rows = [{ kind: 'spell', en: 'Mortal Strike', client: ['Tödlicher Stoß', 'Stoß'], file: 'a.lua', line: 7, text: 'x'.repeat(80), tr: 'y' }, { kind: 'area', en: 'Elwynn', client: ['Elwynn'], file: 'b.lua', line: 12, text: 'Short', tr: 'y' }];
	const lines = formatTable(rows);
	assert.equal(lines.length, 3);
	assert.match(lines[0], /^ {2}kind +English name +client name +file:line +English text$/);
	assert.match(lines[1], /^ {2}spell +Mortal Strike +Tödlicher Stoß \| Stoß +a\.lua:7 +x{59}…$/);
	assert.equal(lines[1].indexOf('a.lua:7'), lines[2].indexOf('b.lua:12'), 'the columns line up');
});

test('a leading article of the client\'s name is not needed in the text', () => {
	assert.equal(audit('Take the Deeprun Tram', 'Nimm die Tiefenbahn').length, 0);
});

test('a name of one word counts only as the whole text; inside a sentence it is an everyday word', () => {
	assert.equal(audit('Subtlety', 'Täuschung').length, 1);
	assert.equal(audit('Subtlety', 'Feingefühl').length, 0);
	assert.equal(audit('Fire the cannon', 'Feuer die Kanone ab, ganz ohne Namen').length, 0);
	assert.equal(audit('Fire', 'Brand').length, 1);
	assert.equal(audit('Smite', 'Strafe').length, 1);
});

test('a talent tree is also asked for by the first words of its name, as a whole text, and a role in brackets is left out', () => {
	assert.equal(audit('Shadow', 'Schatten').length, 1, 'the client says Shadow Magic');
	assert.equal(audit('Shadow', 'Schattenmagie').length, 0);
	assert.equal(audit('Feral', 'Wilder Kampf').length, 0);
	assert.equal(audit('Feral', 'Wildheit').length, 1);
	const [row] = audit('Shadow', 'Schatten');
	assert.deepEqual({ kind: row.kind, en: row.en, client: row.client }, { kind: 'tree', en: 'Shadow', client: ['Schattenmagie'] });
	assert.equal(audit('Holy (healer)', 'Heilig (Heiler)').length, 0);
	assert.equal(audit('Holy (healer)', 'Göttlich (Priester)').length, 1);
	assert.equal(audit('Shadow resistance', 'Schattenwiderstand').length, 0, 'inside a sentence: an everyday word');
	assert.equal(audit('Pet', 'Tier').length, 0, 'a pet\'s skill line is no tree');
	assert.equal(audit('Subtlety', 'Täuschung')[0].kind, 'skill', 'an exact name is named as the client table names it, not twice');
});

test('a name the client leaves in English is not asked for; a name in a longer name is not found inside it', () => {
	assert.equal(audit('Ratchet Bolt hits', 'Ratchet-Blitz trifft').length, 0);
	assert.equal(audit('The Ratchet Docks are closed', 'Die Hafenanlagen sind zu').length, 0);
	assert.equal(audit('Holy Shockwave', 'Heilige Welle').length, 0, 'whole words only');
});

test('placeholders, tokens and colour codes are no part of the English', () => {
	assert.equal(audit('{npc:12} sells %s |cff00ff00Mortal Strike|r', '{npc:12} verkauft %s |cff00ff00Tödlicher Stoß|r').length, 0);
	assert.equal(audit('{area:10} Holy Shock', '{area:10} Heiliger Schock').length, 0);
});

test('texts are read from the lines of a Lua file, escapes decoded, empty translations and comments left out', () => {
	const dir = tmpdir('polestar-audit-');
	fs.mkdirSync(path.join(dir, 'sub'));
	fs.writeFileSync(path.join(dir, 'a.lua'), [
		'local L = ns.L',
		'L["Holy \\"Shock\\""] = "Heiliger \\"Schock\\""',
		'-- L["Smite"] = ""',
		'L["Smite"] = ""',
		'\t["Fire"] = "Feuer",',
		'-- ["Hide"] = "Verbergen",',
	].join('\n'));
	fs.writeFileSync(path.join(dir, 'sub', 'b.lua'), '\t["Subtlety"] = "Täuschung",\n');
	fs.writeFileSync(path.join(dir, 'sub', 'notes.txt'), '["x"] = "y"');
	const files = luaFiles(dir);
	assert.deepEqual(files.map((f) => path.relative(dir, f)), ['a.lua', path.join('sub', 'b.lua')]);
	const texts = readTexts(files);
	assert.deepEqual(texts.map((t) => [path.basename(t.file), t.line, t.en, t.tr]), [
		['a.lua', 2, 'Holy "Shock"', 'Heiliger "Schock"'],
		['a.lua', 5, 'Fire', 'Feuer'],
		['b.lua', 1, 'Subtlety', 'Täuschung'],
	]);
});

test('the client tables come from the cache: the newest build holding every table in English and the language; none stops the audit', async () => {
	const sourcesDir = tmpdir('polestar-audit-wago-');
	const FIELD = { SpellName: 'Name_lang', AreaTable: 'AreaName_lang', SkillLine: 'DisplayName_lang' };
	// SkillLine's category 7 holds the talent trees: row 1 is one, row 2 is not.
	const write = (build, locale, tables) => {
		for (const t of tables) {
			const dir = path.join(sourcesDir, 'wago', build, ...(locale ? [locale] : []));
			fs.mkdirSync(dir, { recursive: true });
			const row = (id) => `${id},${t} ${id} ${locale || 'en'}`;
			fs.writeFileSync(path.join(dir, `${t}.csv`), t === 'SkillLine' ? `ID,${FIELD[t]},CategoryID\n${row(1)},7\n${row(2)},6\n` : `ID,${FIELD[t]}\n${row(1)}\n`);
		}
	};
	const all = Object.keys(FIELD);
	for (const l of [null, 'deDE']) write('1.60.1.1', l, all);
	write('1.60.1.2', null, all);
	write('1.60.1.2', 'deDE', ['SpellName']);
	const got = await loadAuditNames({ sourcesDir, locales: ['deDE'], offline: true });
	assert.equal(got.build, '1.60.1.1');
	assert.equal(got.names.deDE.skill.get(2), 'SkillLine 2 deDE');
	assert.deepEqual([...got.names.deDE.tree.keys()], [1], 'the trees: the skill lines of category 7');
	assert.equal(got.english.area.get(1), 'AreaTable 1 en');
	await assert.rejects(loadAuditNames({ sourcesDir, locales: ['frFR'], offline: true }), /no forever client tables/);
});

test('the command: no finding is exit 0 with a JSON document, no client tables is exit 1 with the reason', () => {
	const sourcesDir = tmpdir('polestar-audit-cli-');
	const FIELD = { SpellName: 'Name_lang', AreaTable: 'AreaName_lang', SkillLine: 'DisplayName_lang' };
	for (const locale of [null, 'deDE']) {
		const dir = path.join(sourcesDir, 'wago', '1.60.1.1', ...(locale ? [locale] : []));
		fs.mkdirSync(dir, { recursive: true });
		for (const [t, f] of Object.entries(FIELD)) fs.writeFileSync(path.join(dir, `${t}.csv`), `ID,${f},CategoryID\n1,Zzyzx Qwerty Name ${locale || 'en'},7\n`);
	}
	const run = (...args) => spawnSync(process.execPath, [path.join(__dirname, '..', 'tools', 'polestar.js'), 'i18n', 'audit', ...args, '--offline', '--sources', sourcesDir], { encoding: 'utf8' });
	const ok = run('deDE', '--json', '--build', '1.60.1.1');
	assert.equal(ok.status, 0, ok.stderr);
	const doc = JSON.parse(ok.stdout);
	assert.equal(doc.build, '1.60.1.1');
	assert.deepEqual(doc.findings, []);
	assert.ok(doc.checked.deDE.texts > 1000, 'the shipped German texts were read');
	const none = run('frFR');
	assert.equal(none.status, 1);
	assert.match(none.stderr, /no forever client tables/);
});
