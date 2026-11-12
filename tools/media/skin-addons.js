'use strict';
// The art of the skin addons in this repository (addon/Polestar_Skin_*),
// drawn in code like Polestar's own (tools/media/skins.js), so it stays
// editable and owned by the project:
//   Polestar_Skin_Vellum/Media/paper.tga  the parchment grain: tileable value
//       noise in four octaves, white with luminance 0.82-0.99, tinted in game
//       with the paper colour (the player's ground colour applies)
//   Polestar_Skin_Aurora/Media/curtain.tga  the aurora in the guide window's
//       band: a ribbon whose bright hem folds across the width, rays rising
//       from it green-teal at the hem turning violet as they climb, clear
//       below the hem; drawn additively, in its own colours
//   Polestar_Skin_Aurora/Media/veil.tga  the same light for a window with no
//       band: the rays alone, brightest at the top edge, fading downward

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

// Aurora's curtain: light only (drawn additively), so its alpha is how bright
// each point glows. The hem's height folds slowly across the width; the rays
// above it are noise stretched upward (one value per column), brightest at
// the hem and fading as they rise; a narrow glow falls below the hem.
const mix = (a, b, t) => [a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t, a[2] + (b[2] - a[2]) * t];
function curtain(w = 512, h = 128) {
	const fold1 = valueNoise(w, 4, 19), fold2 = valueNoise(w, 9, 29);
	const ray1 = valueNoise(w, 56, 7), ray2 = valueNoise(w, 150, 13), swell = valueNoise(w, 6, 31);
	const HEM = [0.5, 1, 0.84], TEAL = [0.2, 0.95, 0.7], VIOLET = [0.56, 0.36, 1], ORCHID = [0.8, 0.4, 0.98];
	const c = new Canvas(w, h);
	for (let x = 0; x < w; x++) {
		const u = (x + 0.5) / w;
		// The hem in the top half (the guide window's tab strip), so the
		// navigator under it keeps a dark ground for its controls.
		const hem = 0.4 + (fold1(x, 0) - 0.5) * 0.2 + (fold2(x, 0) - 0.5) * 0.08;
		const ray = (0.4 + 0.4 * ray1(x, 0) + 0.2 * ray2(x, 0)) * (0.68 + 0.32 * swell(x, 0));
		for (let y = 0; y < h; y++) {
			const above = hem - (y + 0.5) / h; // > 0 above the hem
			const i = above >= 0
				? ray * (0.25 + 0.75 * Math.exp(-above / 0.32)) + 0.22 * Math.exp(-((above / 0.05) ** 2)) * (0.6 + 0.4 * ray)
				: Math.exp(-((above / 0.06) ** 2)) * (0.25 + 0.3 * ray);
			const t = Math.max(0, Math.min(1, above / 0.32));
			let col = mix(TEAL, VIOLET, t * t * (3 - 2 * t));
			if (Math.abs(above) < 0.05) col = mix(HEM, col, Math.abs(above) / 0.05);
			col = mix(col, ORCHID, 0.35 * u * t);
			const p = (y * w + x) * 4;
			c.px[p] = col[0];
			c.px[p + 1] = col[1];
			c.px[p + 2] = col[2];
			c.px[p + 3] = Math.max(0, Math.min(1, i));
		}
	}
	return c;
}

// Aurora's veil, for windows with no band (cards, toasts, menus, dialogs):
// the rays alone, brightest at the top edge and fading to nothing by the
// foot, teal and violet in turn across the width. Light only, like the
// curtain.
function veil(w = 256, h = 64) {
	const ray1 = valueNoise(w, 40, 43), ray2 = valueNoise(w, 96, 47), hue = valueNoise(w, 5, 53);
	const TEAL = [0.2, 0.95, 0.7], VIOLET = [0.56, 0.36, 1];
	const c = new Canvas(w, h);
	for (let x = 0; x < w; x++) {
		const ray = 0.45 + 0.35 * ray1(x, 0) + 0.2 * ray2(x, 0);
		const k = hue(x, 0);
		const col = mix(TEAL, VIOLET, k * k * (3 - 2 * k));
		for (let y = 0; y < h; y++) {
			const p = (y * w + x) * 4;
			c.px[p] = col[0];
			c.px[p + 1] = col[1];
			c.px[p + 2] = col[2];
			c.px[p + 3] = ray * (1 - (y + 0.5) / h) ** 1.8;
		}
	}
	return c;
}

function generate(addonRoot) {
	const addons = path.dirname(addonRoot);
	return [
		paper().write(path.join(addons, 'Polestar_Skin_Vellum', 'Media', 'paper.tga')),
		curtain().write(path.join(addons, 'Polestar_Skin_Aurora', 'Media', 'curtain.tga')),
		veil().write(path.join(addons, 'Polestar_Skin_Aurora', 'Media', 'veil.tga')),
	];
}

module.exports = { name: 'skin-addons', generate };
