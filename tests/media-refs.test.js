'use strict';
// Every texture shipped in addon/Polestar/Media is used: its name appears in
// the Lua, XML or TOC of the addon or of the settings window (Polestar_Options,
// which draws with core's Media), as a quoted name or the end of a path, or it
// is a goal verb's icon, which Theme.lua builds as "icon-" .. verb, or a map
// mark (Media/Map/icon-<name>) named as "map:<name>" or by its bare name (a
// service category's glyph), or one size of an art family Theme.SharpMedia
// picks from (UI/<family>-<size>, a size of Theme.lua's SHARP_SIZES, the
// family quoted in the code: "disc", "switch-edge"). A texture nothing names
// is dead weight in every download; drop it and its generator.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const ADDON = path.join(__dirname, '..', 'addon', 'Polestar');
const OPTIONS = path.join(__dirname, '..', 'addon', 'Polestar_Options');

function sources(dir, out = []) {
	for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
		const p = path.join(dir, e.name);
		if (e.isDirectory()) sources(p, out);
		else if (/\.(lua|xml|toc)$/.test(e.name)) out.push(fs.readFileSync(p, 'utf8'));
	}
	return out;
}

test('every texture in Media is named by the addon', () => {
	const text = sources(ADDON, sources(OPTIONS)).join('\n');
	const theme = fs.readFileSync(path.join(ADDON, 'Theme', 'Theme.lua'), 'utf8');
	const verbs = /for _, v in ipairs\(\{([^}]*)\}\) do\s+VERB_ICON\[v\]/.exec(theme);
	assert.ok(verbs, 'Theme.lua builds VERB_ICON from a verb list');
	const verbIcons = new Set([...verbs[1].matchAll(/"([a-z]+)"/g)].map((m) => `icon-${m[1]}`));
	const sharp = /local SHARP_SIZES = \{([^}]*)\}/.exec(theme);
	assert.ok(sharp, 'Theme.lua lists the sizes Theme.SharpMedia picks from (SHARP_SIZES)');
	const sharpSizes = new Set([...sharp[1].matchAll(/\d+/g)].map((m) => m[0]));
	const unused = [];
	for (const sub of ['UI', 'Nav', 'Map']) {
		for (const file of fs.readdirSync(path.join(ADDON, 'Media', sub))) {
			const name = file.replace(/\.tga$/, '');
			const named = new RegExp(`["\\\\]${name.replace(/[-.]/g, '\\$&')}(["\\r\\n]|$)`, 'm');
			const mark = sub === 'Map' && name.startsWith('icon-')
				&& new RegExp(`[":]${name.slice(5).replace(/[-.]/g, '\\$&')}"`).test(text);
			const family = sub === 'UI' && /^(.+)-(\d+)$/.exec(name);
			const sized = family && sharpSizes.has(family[2]) && text.includes(`"${family[1]}"`);
			if (!verbIcons.has(name) && !named.test(text) && !mark && !sized) unused.push(`${sub}/${file}`);
		}
	}
	assert.deepEqual(unused, []);
});
