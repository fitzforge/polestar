'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { guideState } = require('../tools/lib/i18n/guides');
const { tmpdir } = require('./helpers/tmp');

const RETIRED = '-- No longer in the guide (its English changed or it went away): reuse or delete.';

function retired(lines) {
	const dir = tmpdir('polestar-retired-texts-');
	const file = path.join(dir, 'locales/frFR/guides/main.lua');
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(file, `return { ["Current"] = "Actuel" }\n${RETIRED}\n${lines}\n`);
	const guides = [{ id: 'texts/main', title: 'Current', steps: [], _ast: { source: 'guides/main.guide' } }];
	const state = guideState(dir, {}, guides, ['frFR']).frFR.files.find((f) => f.kind === 'guide');
	assert.equal(state.error, null);
	assert.deepEqual(state.translated, { Current: 'Actuel' }, 'retired comments do not replace the active translation');
	return state.retired;
}

test('retired guide texts preserve literal backslashes in keys and translations', () => {
	assert.deepEqual(retired(String.raw`
-- ["Copy C:\\123"] = "Copier C:\\123\\notes",
-- ["A backslash \\'"] = "Antislash \\' suivi",
-- ["Literal Unicode escape"] = "Copier \\u007b",
-- ["Quoted path"] = "Lire \"C:\\12\"",
-- ["Literal escape"] = "Laisser \\q et \\n",
`), {
		'Copy C:\\123': 'Copier C:\\123\\notes',
		"A backslash \\'": "Antislash \\' suivi",
		'Literal Unicode escape': 'Copier \\u007b',
		'Quoted path': 'Lire "C:\\12"',
		'Literal escape': 'Laisser \\q et \\n',
	});
});

test('retired guide texts decode Lua escapes as bytes, including UTF-8', () => {
	assert.deepEqual(retired(String.raw`
-- ["Cl\195\169"] = "D\195\169j\195\160 vu",
-- ["Escaped apostrophe"] = "L\'abbaye",
-- ["Controls"] = "\a\b\f\n\r\t\v\0007",
-- ["Decimal widths"] = "\9\09\0099",
-- ["Unicode"] = "Déjà vu — 中文 🧭",
`), {
		Clé: 'Déjà vu',
		'Escaped apostrophe': "L'abbaye",
		Controls: '\x07\b\f\n\r\t\v\x007',
		'Decimal widths': '\t\t\t9',
		Unicode: 'Déjà vu — 中文 🧭',
	});
});

test('malformed and untranslated retired lines remain excluded', () => {
	assert.deepEqual(retired(String.raw`
-- ["Bad value"] = "bad\q",
-- ["bad\q"] = "Bad key",
-- ["Unfinished"] = "no end,
-- ["Empty"] = "",
-- ["Expression"] = string.upper("do not execute"),
-- ["Kept"] = "Conservé",
`), { Kept: 'Conservé' });
});
