'use strict';
// tools/preview/render.js draws Line regions (CreateLine: the route lines on
// the world map and the minimap): a stroke between two ends given relative to
// a frame's point, in its colour and thickness, or its texture stretched
// along it; a line is a region of its frame, never a frame of its own.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { svg } = require('../tools/preview/render');

const UI = { id: 1, seq: 0, kind: 'Frame', name: 'UIParent', points: [], w: 1920, h: 1080, shown: true, alpha: 1 };
const PANEL = { id: 2, seq: 1, kind: 'Frame', parent: 1, points: [{ point: 'TOPLEFT', rel: 1, relPoint: 'TOPLEFT', x: 100, y: -50 }], w: 200, h: 100, shown: true, alpha: 1, scale: 2 };
const line = (id, extra) => ({ id, seq: id, kind: 'Line', parent: 2, points: [], shown: true, alpha: 1, layer: 'ARTWORK', ...extra });

function draw(objects) {
	const uris = [];
	const textures = { uri: (name, tint) => (uris.push([name, tint]), `tex:${name}`) };
	const out = svg({ objects }, { fonts: {}, textures, roots: ['UIParent'], viewport: { x: 0, y: 0, w: 1920, h: 1080 } });
	return { body: out.body, uris, frames: out.layout.frames.map((f) => f.id) };
}

test('a coloured line is a stroke between its two ends, offsets and thickness in its frame\'s scale', () => {
	// A line's alpha is its vertex colour's (one value in the client; the stub's SetAlpha writes both).
	const { body, frames } = draw([UI, PANEL, line(3, {
		color: [1, 0, 0, 1], vertexColor: [1, 0.5, 1, 0.5], alpha: 0.5,
		line: { from: { point: 'TOPLEFT', rel: 2, x: 10, y: -20 }, to: { point: 'TOPLEFT', rel: 2, x: 60, y: -20 }, thickness: 3 },
	})]);
	// The panel (scale 2, so its own offset doubles too) sits at (200, 100): (10, -20) is (220, 140), (60, -20) is (320, 140).
	assert.match(body, /<line x1="220" y1="140" x2="320" y2="140" stroke="rgb\(255,0,0\)" stroke-opacity="0.5" stroke-width="6"\/>/);
	assert.deepEqual(frames, [1, 2], 'the line is drawn with its frame, not as one');
});

test('a textured line stretches its texture along it, turned to its direction; a line without both ends draws nothing', () => {
	const { body, uris } = draw([UI, PANEL, line(3, {
		texture: 'Interface\\AddOns\\Polestar\\Media\\Nav\\pin-fill', vertexColor: [0, 1, 0, 1],
		line: { from: { point: 'TOPLEFT', rel: 2, x: 0, y: 0 }, to: { point: 'TOPLEFT', rel: 2, x: 0, y: -10 }, thickness: 2 },
	}), line(4, { color: [1, 1, 1, 1], line: { from: { point: 'TOPLEFT', rel: 2, x: 0, y: 0 }, thickness: 2 } })]);
	assert.deepEqual(uris, [['Nav/pin-fill', [0, 1, 0, 1]]]);
	assert.match(body, /<image x="-10" y="-2" width="20" height="4" preserveAspectRatio="none" opacity="1" href="tex:Nav\/pin-fill" transform="translate\(200 110\) rotate\(90\)"\/>/);
	assert.equal((body.match(/<line|<image/g) || []).length, 1);
});
