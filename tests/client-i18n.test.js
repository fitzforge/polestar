'use strict';
// Polestar Client's translations (apps/client/src/locales, apps/client/scripts/i18n.js): every
// text the code writes through t()/tn()/msg() (frontend) and t!/tn! (backend) can be extracted,
// no catalog has a key the English lacks, every translation keeps the English placeholders, a
// plural has the forms its language needs, each file says who made it, and the frontend, the
// backend and the files list the same languages. Also: which language a system's preferences
// pick (apps/client/src/lib/languages.ts).

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const CLIENT = path.join(__dirname, '..', 'apps', 'client');
const i18n = () => import(path.join(CLIENT, 'scripts', 'i18n.js'));

test('every text in the client code is extractable', async () => {
	const { extract } = await i18n();
	const { keys, problems } = extract();
	assert.deepEqual(problems, []);
	assert.ok(keys.size > 300, `only ${keys.size} texts found`);
	assert.ok(keys.has('Pause uploads'), 'the tray\'s t!("Pause uploads") is found');
});

test('the catalogs match the English: keys, placeholders, plural forms, @meta', async () => {
	const { check } = await i18n();
	assert.deepEqual(check(), []);
});

test('the frontend, the backend and src/locales list the same languages', async () => {
	const { LOCALES } = await i18n();
	const { LANGUAGES } = await import(path.join(CLIENT, 'src', 'lib', 'languages.ts'));
	assert.deepEqual(LANGUAGES.map((l) => l.code).filter((c) => c !== 'enUS').sort(), [...LOCALES].sort());
	const rust = fs.readFileSync(path.join(CLIENT, 'src-tauri', 'src', 'i18n.rs'), 'utf8');
	const catalogs = [...rust.matchAll(/\("(\w{4})", include_str!\("\.\.\/\.\.\/src\/locales\/(\w{4})\.json"\)\)/g)];
	assert.deepEqual(catalogs.map((m) => m[1]), LOCALES);
	assert.ok(catalogs.every((m) => m[1] === m[2]));
});

test('the check finds a stray key, a lost placeholder and a missing Russian plural form', async (t) => {
	const { check, file, load, extract } = await i18n();
	const { keys } = extract();
	const text = [...keys].find(([k, v]) => !v.plural && /\{\w+\}/.test(k))[0];
	const plural = [...keys].find(([, v]) => v.plural)[0];
	const original = fs.readFileSync(file('ruRU'), 'utf8');
	t.after(() => fs.writeFileSync(file('ruRU'), original));
	const cat = load('ruRU');
	cat['Not a text the code has'] = 'x';
	cat[text] = 'без заполнителя';
	cat[plural] = { one: '{count} x', other: '{count} x' };
	fs.writeFileSync(file('ruRU'), JSON.stringify(cat));
	const problems = check().join('\n');
	assert.match(problems, /"Not a text the code has" is not in the code/);
	assert.ok(problems.includes(`"${text}" has {}`), problems);
	assert.ok(problems.includes(`"${plural}" lacks its "few" form`), problems);
});

test('the system language picks the client language', async () => {
	const { detect } = await import(path.join(CLIENT, 'src', 'lib', 'languages.ts'));
	const cases = {
		'de-AT': 'deDE',
		'es-MX': 'esMX',
		'es-419': 'esMX',
		'es-AR': 'esMX',
		'es-ES': 'esES',
		es: 'esES',
		'fr-CA': 'frFR',
		'pt-BR': 'ptBR',
		pt: 'ptBR',
		'ko-KR': 'koKR',
		ru: 'ruRU',
		'zh-CN': 'zhCN',
		'zh-Hans': 'zhCN',
		'zh-SG': 'zhCN',
		'zh-TW': 'zhTW',
		'zh-HK': 'zhTW',
		'zh-Hant': 'zhTW',
		'zh-Hant-CN': 'zhTW',
		'it-IT': 'enUS',
		'en-GB': 'enUS',
	};
	for (const [system, client] of Object.entries(cases)) assert.equal(detect([system]), client, system);
	// The first language the client has wins; English first means English.
	assert.equal(detect(['it-IT', 'ru-RU', 'de-DE']), 'ruRU');
	assert.equal(detect(['en-US', 'de-DE']), 'enUS');
	assert.equal(detect(['not a tag', 'ko']), 'koKR');
	assert.equal(detect([]), 'enUS');
});
