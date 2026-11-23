'use strict';
// A guide text a language leaves untranslated ("") while the same English is
// translated elsewhere in that language, every copy alike, shows English for
// nothing: `forge i18n guides sync` keeps each guide's file apart, so a text a
// guide gains (or gets back, as "The Villards" in Hillsbrad after round 2)
// starts empty though another guide, or the file's own "No longer in the
// guide" block, has its translation. The 0.3.5 restore filled these by exact
// key; this keeps them filled. Texts whose copies disagree are left to the
// translators.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const BASE = path.join(__dirname, '..', 'guides', 'locales');
const LINE = /^\s*(--\s*)?\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)",?\s*$/;

function luaFiles(dir) {
	const out = [];
	for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
		const p = path.join(dir, e.name);
		if (e.isDirectory()) out.push(...luaFiles(p));
		else if (e.name.endsWith('.lua')) out.push(p);
	}
	return out;
}

test('a guide text left empty takes no English its language already translates one way', () => {
	const missed = [];
	for (const locale of fs.readdirSync(BASE)) {
		const translations = new Map();
		const empty = [];
		for (const file of luaFiles(path.join(BASE, locale))) {
			for (const line of fs.readFileSync(file, 'utf8').split('\n')) {
				const m = LINE.exec(line);
				if (!m) continue;
				const [, retired, english, text] = m;
				if (text) {
					if (!translations.has(english)) translations.set(english, new Set());
					translations.get(english).add(text);
				} else if (!retired) empty.push([path.relative(BASE, file), english]);
			}
		}
		for (const [file, english] of empty) {
			if (translations.get(english)?.size === 1) missed.push(`${file}: ${english}`);
		}
	}
	assert.deepEqual(missed, []);
});
