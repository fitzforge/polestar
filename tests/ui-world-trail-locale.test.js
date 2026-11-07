'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const root = path.join(__dirname, '..', 'addon', 'Polestar');
const retired = 'Three choices to start with. Everything else is in %s.';
test('ground-trail setup retires the old three-choice locale key without losing translations', () => {
	const welcome = fs.readFileSync(path.join(root, 'UI', 'Welcome.lua'), 'utf8');
	assert.ok(welcome.includes('L["Start with these choices. Everything else is in %s."]'));
	assert.ok(!welcome.includes(`L["${retired}"]`));
	const locales = ['deDE', 'esES', 'esMX', 'frFR', 'koKR', 'ptBR', 'ruRU', 'zhCN', 'zhTW'];
	for (const locale of locales) {
		const lines = fs.readFileSync(path.join(root, 'Locales', `${locale}.lua`), 'utf8').split(/\r?\n/);
		const entries = lines.filter(line => line.includes(`L["${retired}"]`));
		assert.equal(entries.length, 1, `${locale}: preserve the previous translation for its translator`);
		assert.ok(entries[0].trimStart().startsWith('--'), `${locale}: retired English key must not remain an active locale entry`);
	}
});
