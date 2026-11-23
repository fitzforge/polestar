'use strict';
// tools/preview/render.js draws a picture faded with SetGradient (a skin's
// art): its alpha runs from one end to the other as a mask, the ends' mean
// colour tints it, and the texture's own alpha (SetAlpha, one value with its
// vertex colour's in the client) still dims the whole picture.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { svg } = require('../tools/preview/render');

const UI = { id: 1, seq: 0, kind: 'Frame', name: 'UIParent', points: [], w: 1920, h: 1080, shown: true, alpha: 1 };
const PANEL = { id: 2, seq: 1, kind: 'Frame', parent: 1, points: [{ point: 'TOPLEFT', rel: 1, relPoint: 'TOPLEFT', x: 100, y: -50 }], w: 200, h: 100, shown: true, alpha: 1 };
const art = (extra) => ({
	id: 3, seq: 2, kind: 'Texture', parent: 2, layer: 'ARTWORK', shown: true, alpha: 1,
	points: [{ point: 'TOPLEFT', rel: 2, relPoint: 'TOPLEFT', x: 0, y: 0 }, { point: 'BOTTOMRIGHT', rel: 2, relPoint: 'BOTTOMRIGHT', x: 0, y: 0 }],
	texture: 'Interface\\AddOns\\Polestar\\Media\\Nav\\pin-fill',
	gradient: { orientation: 'VERTICAL', min: [1, 1, 1, 0], max: [0.5, 0.5, 0.5, 0.8] },
	...extra,
});

function draw(objects) {
	const uris = [];
	const textures = { uri: (name, tint) => (uris.push([name, tint]), `tex:${name}`), size: () => ({ w: 8, h: 8 }) };
	const out = svg({ objects }, { fonts: {}, textures, roots: ['UIParent'], viewport: { x: 0, y: 0, w: 1920, h: 1080 } });
	return { body: out.body, defs: out.defs ?? '', uris };
}

test('a gradient picture fades through a mask, tinted by its ends; SetAlpha still dims it', () => {
	// SetVertexColor(1, 1, 1, 1), SetGradient(...), SetAlpha(0.4): the stub writes 0.4 into both.
	const { body, uris } = draw([UI, PANEL, art({ vertexColor: [1, 1, 1, 0.4], alpha: 0.4 })]);
	assert.deepEqual(uris, [['Nav/pin-fill', [0.75, 0.75, 0.75, 1]]], 'the ends\' mean colour tints it');
	assert.match(body, /<g mask="url\(#p?gm3\)"><image [^>]*opacity="0.4" href="tex:Nav\/pin-fill"/, 'masked, at the texture\'s own alpha');
	// Without SetAlpha the gradient's ends alone say how opaque it is.
	const plain = draw([UI, PANEL, art({ vertexColor: [1, 1, 1, 1] })]);
	assert.match(plain.body, /<image [^>]*opacity="1" href="tex:Nav\/pin-fill"/);
});
