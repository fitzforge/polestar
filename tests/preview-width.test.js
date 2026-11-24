'use strict';
// The preview lays out a FontString at width 0 (SetWidth(0)) as the client
// does: as wide as its text; and text-fit's optional overlap check finds a
// string drawn over another one in the same window.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { resolve, measure } = require('../tools/preview/render');
const { audit, describe, fontsFor } = require('../tools/preview/fit');

const fonts = fontsFor(1);
const FONT = ['Inter-Regular.ttf', 12];
const frame = { id: 1, kind: 'Frame', name: 'PolestarMenu', shown: true, w: 300, h: 40, points: [{ point: 'TOPLEFT', rel: null, relPoint: 'TOPLEFT', x: 100, y: -100 }] };
const fs = (id, text, extra) => ({ id, kind: 'FontString', parent: 1, shown: true, text, font: FONT, points: [], ...extra });

test('a FontString at width 0 without a second anchor is as wide as its text, and what is anchored to its right lands after the text', () => {
	const objects = [
		frame,
		fs(2, 'Version 0.3.7', { w: 0, justifyH: 'LEFT', points: [{ point: 'LEFT', rel: 1, relPoint: 'LEFT', x: 10, y: 0 }] }),
		fs(3, '[BETA]', { justifyH: 'LEFT', points: [{ point: 'LEFT', rel: 2, relPoint: 'RIGHT', x: 4, y: 0 }] }),
	];
	const { rects } = resolve(objects, fonts);
	const text = measure(fonts, FONT, 'Version 0.3.7');
	assert.ok(text > 20);
	assert.equal(rects.get(2).w, text);
	assert.equal(rects.get(3).x, rects.get(2).x + text + 4);
});

test('a width other than 0, or two anchors, still sets a FontString\'s width', () => {
	const objects = [
		frame,
		fs(2, 'Version 0.3.7', { w: 30, points: [{ point: 'LEFT', rel: 1, relPoint: 'LEFT', x: 10, y: 0 }] }),
		fs(3, 'Spread', { w: 0, points: [{ point: 'LEFT', rel: 1, relPoint: 'LEFT', x: 0, y: 0 }, { point: 'RIGHT', rel: 1, relPoint: 'RIGHT', x: 0, y: 0 }] }),
	];
	const { rects } = resolve(objects, fonts);
	assert.equal(rects.get(2).w, 30);
	assert.equal(rects.get(3).w, 300);
});

test('text-fit finds text drawn over other text only when asked for overlap', () => {
	const objects = () => [
		frame,
		fs(2, 'A long left label here', { justifyH: 'LEFT', points: [{ point: 'LEFT', rel: 1, relPoint: 'LEFT', x: 10, y: 0 }] }),
		fs(3, 'Right', { justifyH: 'LEFT', points: [{ point: 'LEFT', rel: 1, relPoint: 'LEFT', x: 40, y: 0 }] }),
		fs(4, 'Far away', { justifyH: 'LEFT', points: [{ point: 'RIGHT', rel: 1, relPoint: 'RIGHT', x: -5, y: 0 }] }),
	];
	assert.deepEqual(audit({ objects: objects() }, ['PolestarMenu'], fonts), [], 'not a default check');
	const found = audit({ objects: objects() }, ['PolestarMenu'], fonts, ['overlap']);
	assert.equal(found.length, 1, JSON.stringify(found));
	assert.equal(found[0].text, 'A long left label here');
	assert.match(describe(found[0]), /^"A long left label here" overlaps "Right" by [\d.]+px in width$/);
});
