'use strict';
// tools/preview/render.js draws a FontString's inline textures (the client's
// `|T<path>:...|t` escape: the group, dungeon and Forever marks after a name)
// as their textures, one em wide, tinted by the escape's colour fields; never
// as the escape's text.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { svg, measure } = require('../tools/preview/render');
const { fontsFor } = require('../tools/preview/fit');

const fonts = fontsFor(1);
const FONT = ['Inter-Regular.ttf', 12];
const UI = { id: 1, seq: 0, kind: 'Frame', name: 'UIParent', points: [], w: 1920, h: 1080, shown: true, alpha: 1 };
const GLYPH = '|TInterface\\AddOns\\Polestar\\Media\\UI\\icon-group:0:0:0:0:32:32:0:32:0:32:255:154:60|t';

test('an inline texture is drawn as its texture, one em wide, in its tint; its escape is no text', () => {
	const uris = [];
	const textures = { uri: (name, tint, tc) => (uris.push([name, tint, tc]), `tex:${name}`) };
	const text = { id: 2, seq: 1, kind: 'FontString', parent: 1, shown: true, alpha: 1, layer: 'ARTWORK', text: `Mokk ${GLYPH}`, font: FONT,
		textColor: [1, 1, 1, 1], points: [{ point: 'TOPLEFT', rel: 1, relPoint: 'TOPLEFT', x: 100, y: -100 }] };
	const out = svg({ objects: [UI, text] }, { fonts, textures, roots: ['UIParent'], shared: { glyphs: new Set(), defs: [] }, viewport: { x: 0, y: 0, w: 1920, h: 1080 } });
	assert.deepEqual(uris, [['icon-group', [1, 154 / 255, 60 / 255, 1], [0, 1, 0, 1]]]);
	const x = 100 + measure(fonts, FONT, 'Mokk ');
	assert.match(out.body, new RegExp(`<image x="${Math.round(x * 100) / 100}" y="100" width="12" height="12" preserveAspectRatio="none" opacity="1" href="tex:icon-group"/>`));
	assert.doesNotMatch(out.body, /Interface|\|T/);
	assert.equal(measure(fonts, FONT, '\uE000'), 12, 'one em wide');
});
