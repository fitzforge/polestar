'use strict';
// Quality of Life glyphs: white shapes the addon tints at runtime, in the same
// 24-unit grid, 2.25 stroke and 32 px size as the UI glyphs (tools/media/ui.js),
// so they sit in the same family.
//
//   qol-toggles  options page: two switches
//   qol-target   target button: crosshair
//   qol-spirit   Spirit Healer pin: an ankh
//   qol-corpse   corpse pin: a headstone
//   qol-upgrade  quest reward badge: an upgrade, a bold up arrow with a dark rim
//   qol-coin     quest reward badge: sells for most, a coin with a dark rim
//   qol-ring     flight map destination marker: a ring with four ticks
//   qol-fly-arrow flight map destination: a bold down arrow with a heavy dark rim
//   qol-fly-ring  flight map destination: the ring on the node, heavy dark rim
//
//   node tools/polestar.js media qol

const path = require('node:path');
const { Canvas, sdf } = require('../lib/tga');

const SIZE = 32;
const K = SIZE / 24;
const STROKE = 2.25;
const g = (v) => v * K;

const line = (ax, ay, bx, by, w = STROKE) => sdf.segment(g(ax), g(ay), g(bx), g(by), g(w) / 2);
const dot = (cx, cy, r) => sdf.circle(g(cx), g(cy), g(r));
const ring = (cx, cy, r, w = STROKE) => sdf.ring(g(cx), g(cy), g(r), g(w));
const box = (cx, cy, hw, hh, r = 0) => sdf.box(g(cx), g(cy), g(hw), g(hh), g(r));
const poly = (pts) => sdf.polygon(pts.map(([x, y]) => [g(x), g(y)]));
const { union, subtract, intersect } = sdf;

// An up arrow: the head and a short stem, corners eased so it reads at 18 px.
function arrow() {
	const head = poly([[12, 3.6], [19.6, 11.8], [4.4, 11.8]]);
	const stem = box(12, 15.4, 3.1, 5, 0.6);
	return sdf.offset(union(head, stem), g(0.7));
}

// The up arrow turned over: it bobs above a flight map node, pointing at it.
function arrowDown() {
	const head = poly([[12, 20.4], [4.4, 12.2], [19.6, 12.2]]);
	const stem = box(12, 8.6, 3.1, 5, 0.6);
	return sdf.offset(union(head, stem), g(0.7));
}

// A coin: a disc with its rim engraved.
function coin() {
	return subtract(dot(12, 12, 8.6), ring(12, 12, 5.9, 1.5));
}

// A switch: a pill outline with its knob on one side.
function toggle(cy, on) {
	const pill = subtract(box(12, cy, 9, 3.8, 3.8), box(12, cy, 6.9, 1.7, 1.7));
	return union(pill, dot(on ? 17.2 : 6.8, cy, on ? 2.6 : 1.9));
}

const GLYPHS = {
	'qol-toggles': union(toggle(7, true), toggle(17, false)),
	'qol-target': union(
		ring(12, 12, 6.6),
		line(12, 2.2, 12, 7.4),
		line(12, 16.6, 12, 21.8),
		line(2.2, 12, 7.4, 12),
		line(16.6, 12, 21.8, 12),
		dot(12, 12, 1.5),
	),
	'qol-spirit': union(
		ring(12, 7.2, 3.6, 2.4),
		line(12, 11, 12, 21.5, 2.6),
		line(6, 12.6, 18, 12.6, 2.6),
	),
	'qol-corpse': subtract(
		union(intersect(dot(12, 9.5, 7), box(12, 6, 7, 6)), box(12, 15, 7, 6)),
		union(line(12, 7, 12, 15, 1.8), line(9, 10, 15, 10, 1.8)),
	),
	'qol-ring': union(
		ring(12, 12, 7.5, 2.4),
		line(12, 1.8, 12, 4.2, 2.2),
		line(12, 19.8, 12, 22.2, 2.2),
		line(1.8, 12, 4.2, 12, 2.2),
		line(19.8, 12, 22.2, 12, 2.2),
	),
};

function glyph(shape) {
	return new Canvas(SIZE, SIZE).fill(shape, [1, 1, 1, 1]);
}

// Reward badges sit on any item icon: a dark rim under the tintable shape.
function badge(shape) {
	const c = new Canvas(SIZE, SIZE);
	c.fill(sdf.offset(shape, g(1.5)), [0, 0, 0, 0.7], { feather: 2 });
	c.fill(shape, [1, 1, 1, 1]);
	return c;
}
const BADGES = { 'qol-upgrade': arrow(), 'qol-coin': coin() };

// Flight map marks sit on the taxi map's light parchment, where the gold
// accent alone disappears: a heavier, nearly opaque dark rim keeps the
// tinted shape readable there.
function rimmed(shape) {
	const c = new Canvas(SIZE, SIZE);
	c.fill(sdf.offset(shape, g(2.1)), [0, 0, 0, 0.9], { feather: 1.5 });
	c.fill(shape, [1, 1, 1, 1]);
	return c;
}
const MARKS = { 'qol-fly-arrow': arrowDown(), 'qol-fly-ring': ring(12, 12, 6.8, 2.6) };

function generate(addonRoot) {
	const dir = path.join(addonRoot, 'Media', 'UI');
	const written = [];
	for (const [name, shape] of Object.entries(GLYPHS)) written.push(glyph(shape).write(path.join(dir, `${name}.tga`)));
	for (const [name, shape] of Object.entries(BADGES)) written.push(badge(shape).write(path.join(dir, `${name}.tga`)));
	for (const [name, shape] of Object.entries(MARKS)) written.push(rimmed(shape).write(path.join(dir, `${name}.tga`)));
	return written;
}

module.exports = { name: 'qol', generate, textures: [...Object.keys(GLYPHS), ...Object.keys(BADGES), ...Object.keys(MARKS)] };
