'use strict';
// The game's AddOns list in every client language: each Polestar addon's TOC
// carries `## Title-<locale>` and `## Notes-<locale>` for every locale, as
// tools/lib/i18n/toc.js writes them, the committed TOCs and the generated
// ones (Codex, QuestDB, ItemDB, the guides, the names packs) alike.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tocText, tocLines } = require('../tools/lib/i18n/toc');
const { LOCALE_CODES } = require('../tools/lib/i18n/locales');

const ADDONS = path.join(__dirname, '..', 'addon');

function fields(text) {
	const out = {};
	for (const m of text.matchAll(/^## ([\w-]+):[ \t]*(.*?)[ \t]*$/gm)) out[m[1]] = m[2];
	return out;
}

test('every addon TOC names the addon in every client language, as toc.js has it', () => {
	const tocs = fs.readdirSync(ADDONS).filter((d) => fs.existsSync(path.join(ADDONS, d, `${d}.toc`)));
	assert.ok(tocs.includes('Polestar') && tocs.includes('Polestar_Guides') && tocs.includes('Polestar_Names_ruRU'));
	for (const addon of tocs) {
		const f = fields(fs.readFileSync(path.join(ADDONS, addon, `${addon}.toc`), 'utf8'));
		const want = tocText(addon);
		for (const l of LOCALE_CODES) {
			assert.equal(f[`Title-${l}`], want[l].title, `${addon} Title-${l}`);
			assert.equal(f[`Notes-${l}`], want[l].notes, `${addon} Notes-${l}`);
		}
	}
});

test('the translations keep Polestar\'s name, fill every locale, and the per-language packs name their language', () => {
	for (const addon of ['Polestar', 'Polestar_Codex', 'Polestar_Guides', 'Polestar_ItemDB', 'Polestar_Nav', 'Polestar_QuestDB', 'Polestar_Recorder', 'Polestar_Names_deDE', 'Polestar_Guides_zhTW']) {
		const t = tocText(addon);
		for (const l of LOCALE_CODES) {
			assert.ok(t[l].title.includes('Polestar') && t[l].notes, `${addon} ${l}`);
			assert.ok(!/%\d/.test(t[l].title + t[l].notes), `${addon} ${l} filled`);
		}
	}
	assert.equal(tocText('Polestar_Names_deDE').ruRU.notes.includes('немецкий'), true);
	assert.equal(tocLines('Polestar_Codex').length, LOCALE_CODES.length * 2);
	assert.throws(() => tocText('Polestar_Unknown'), /toc\.js/);
});
