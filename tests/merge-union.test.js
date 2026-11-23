'use strict';
// .gitattributes merges some files with `merge=union` (CONTRIBUTING.md, "Merge conflicts"): a local merge keeps
// both sides' lines instead of stopping on a conflict. That is safe only where every entry is one self-contained
// line whose order does not matter, so this holds every such file to it: today the interface translations,
// addon/Polestar_<locale>/Interface.lua, one `L["..."] = "..."` line a key. JSON, the compiled Texts.lua and the
// changelog fragments (multi-line entries) never take it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const ROOT = path.join(__dirname, '..');
const git = (args, input) => {
	const r = spawnSync('git', args, { cwd: ROOT, input, encoding: 'utf8', maxBuffer: 64 << 20 });
	assert.equal(r.status, 0, r.stderr);
	return r.stdout;
};

// Every tracked file git merges with the union driver.
function unionFiles() {
	const out = git(['check-attr', '-z', '--stdin', 'merge'], git(['ls-files', '-z'])).split('\0');
	const files = [];
	for (let i = 0; i + 2 < out.length; i += 3) if (out[i + 2] === 'union') files.push(out[i]);
	return files.sort();
}

// A locale file's lines: its fixed opening, blank lines, comments (group headings, keys still to translate,
// retired translations) and one translation a line.
const LOCALE_LINE = [/^$/, /^--( .*)?$/, /^L\["(?:[^"\\]|\\.)*"\] = "(?:[^"\\]|\\.)*"$/, /^local ns = Polestar$/, /^if not \(ns and ns\.Names and ns\.Names\.Language and ns\.Names\.Language\(\) == "[a-z]{2}[A-Z]{2}"\) then return end$/, /^local L = ns\.L$/];

test('merge=union covers the interface translation files and nothing else', () => {
	const locales = git(['ls-files', 'addon/']).split('\n').filter((f) => /^addon\/Polestar_[a-z]{2}[A-Z]{2}\/Interface\.lua$/.test(f)).sort();
	assert.ok(locales.length >= 9, locales.join(', '));
	assert.deepEqual(unionFiles(), locales);
});

test('every merge=union file holds one self-contained entry a line', () => {
	const files = unionFiles();
	for (const f of files) {
		assert.ok(!/\.json$/i.test(f), `${f}: JSON never merges line by line`);
		const bad = fs.readFileSync(path.join(ROOT, f), 'utf8').replace(/\n$/, '').split('\n').map((l, i) => [i + 1, l]).filter(([, l]) => !LOCALE_LINE.some((re) => re.test(l)));
		assert.deepEqual(bad.slice(0, 5), [], `${f}: lines that are not one entry each; take merge=union off the file or keep each entry on one line`);
	}
});
