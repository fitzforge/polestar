'use strict';
// Map pin icons drawn here (Maps/TravelPins.lua) where the client has no
// icon of its own to scale (Media/UI/game-*.tga): small illustrated
// pictures that follow every colour scheme. Each icon is two 64 px layers:
//
//   map-<name>        tinted with the pin's colour at runtime: the body white
//                     (full colour), its shade and deep shade grey, joints
//                     and edges near black, and a dark rim round it all
//                     (black stays black under a tint), so it reads on any
//                     zone art.
//   map-<name>-shine  drawn untinted over it (Pins `shine`): white highlights
//                     the tint can't reach, light from the upper left.
//
// Shapes are signed distance functions in pixels on the 64 px canvas.
//
//   node tools/polestar.js media mapicons

const path = require('node:path');
const { Canvas, sdf } = require('../lib/tga');

const SIZE = 64;
const { union, intersect, offset, circle, box, segment } = sdf;

const TONE = { lit: 1, shade: 0.66, deep: 0.42, line: 0.14 };
const RIM = 3; // px of dark rim round the silhouette

// A half plane, for shading the part of a shape below y0.
const below = (y0) => (x, y) => y0 - y;

// Draws an icon: { body, shade, deep, lines, shine } (body a shape, the rest
// lists of shapes, each clipped to the body).
function draw({ body, shade = [], deep = [], lines = [], shine = [] }) {
	const tint = new Canvas(SIZE, SIZE);
	tint.fill(offset(body, RIM), [0, 0, 0, 0.82], { feather: 1.5 });
	tint.fill(body, [TONE.lit, TONE.lit, TONE.lit, 1]);
	const tone = (shapes, v) => shapes.forEach((s) => tint.fill(intersect(body, s), [v, v, v, 1]));
	tone(shade, TONE.shade);
	tone(deep, TONE.deep);
	tone(lines, TONE.line);
	const gloss = new Canvas(SIZE, SIZE);
	shine.forEach((s) => gloss.fill(intersect(body, s), [1, 1, 1, 0.6], { feather: 1.2 }));
	return { tint, gloss };
}

// The Deeprun Tram: a rail car from the side, its windows lit, on its rail.
function tram() {
	const car = union(box(32, 33, 25, 12, 4), box(32, 19, 20, 3, 2));
	const wheels = union(circle(18, 48, 5.5), circle(46, 48, 5.5));
	const rail = box(32, 56, 29, 1.8, 0.8);
	const windows = union(box(17, 30, 5, 5, 1), box(32, 30, 5, 5, 1), box(47, 30, 5, 5, 1));
	const body = union(car, wheels, rail);
	return draw({
		body,
		shade: [intersect(car, below(38))],
		deep: [windows, wheels, rail],
		lines: [segment(9, 38, 55, 38, 0.8), segment(24.5, 24, 24.5, 44, 0.7), segment(39.5, 24, 39.5, 44, 0.7)],
		shine: [
			segment(13, 27, 13, 32, 1.1), segment(28, 27, 28, 32, 1.1), segment(43, 27, 43, 32, 1.1),
			segment(13, 22.5, 51, 22.5, 0.9), circle(18, 48, 1.6), circle(46, 48, 1.6), circle(55, 40, 1.6),
		],
	});
}

const ICONS = { tram };

function generate(addonRoot) {
	const dir = path.join(addonRoot, 'Media', 'UI');
	const written = [];
	for (const [name, make] of Object.entries(ICONS)) {
		const { tint, gloss } = make();
		written.push(tint.write(path.join(dir, `map-${name}.tga`)));
		written.push(gloss.write(path.join(dir, `map-${name}-shine.tga`)));
	}
	return written;
}

module.exports = { name: 'mapicons', generate, textures: Object.keys(ICONS).flatMap((n) => [`map-${n}`, `map-${n}-shine`]) };
