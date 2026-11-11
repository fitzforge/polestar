'use strict';
// The art of the skin addons in this repository (addon/Polestar_Skin_*),
// drawn in code like Polestar's own (tools/media/skins.js), so it stays
// editable and owned by the project:
//   Polestar_Skin_Vellum/Media/paper.tga  the parchment grain: tileable value
//       noise in four octaves, white with luminance 0.82-0.99, tinted in game
//       with the paper colour (the player's ground colour applies)

const path = require('node:path');
const { Canvas } = require('../lib/tga');

// Deterministic lattice noise wrapping at `n` cells, so the paper tiles.
function lattice(n, seed) {
	const v = new Float32Array(n * n);
	let s = seed >>> 0;
	for (let i = 0; i < n * n; i++) {
		s = (s * 1664525 + 1013904223) >>> 0;
		v[i] = s / 4294967296;
	}
	return (x, y) => v[(((y % n) + n) % n) * n + (((x % n) + n) % n)];
}
const smooth = (t) => t * t * (3 - 2 * t);
function valueNoise(size, cells, seed) {
	const at = lattice(cells, seed);
	return (px, py) => {
		const fx = (px / size) * cells, fy = (py / size) * cells;
		const x0 = Math.floor(fx), y0 = Math.floor(fy);
		const tx = smooth(fx - x0), ty = smooth(fy - y0);
		const a = at(x0, y0), b = at(x0 + 1, y0), c = at(x0, y0 + 1), d = at(x0 + 1, y0 + 1);
		return (a * (1 - tx) + b * tx) * (1 - ty) + (c * (1 - tx) + d * tx) * ty;
	};
}

// Vellum's paper: broad soft mottling with a little fibre.
function paper(size = 512) {
	const n1 = valueNoise(size, 6, 11), n2 = valueNoise(size, 14, 23), n3 = valueNoise(size, 40, 37), n4 = valueNoise(size, 128, 41);
	const c = new Canvas(size, size);
	for (let y = 0; y < size; y++) {
		for (let x = 0; x < size; x++) {
			const m = n1(x, y) * 0.5 + n2(x, y) * 0.3 + n3(x, y) * 0.14 + n4(x, y) * 0.06;
			const l = Math.max(0, Math.min(1, 0.905 + (m - 0.5) * 0.17));
			const i = (y * size + x) * 4;
			c.px[i] = c.px[i + 1] = c.px[i + 2] = l;
			c.px[i + 3] = 1;
		}
	}
	return c;
}

function generate(addonRoot) {
	const addons = path.dirname(addonRoot);
	return [paper().write(path.join(addons, 'Polestar_Skin_Vellum', 'Media', 'paper.tga'))];
}

module.exports = { name: 'skin-addons', generate };
