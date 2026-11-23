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
//   Polestar_Skin_Hairline/Media/dart.tga, dart-edge.tga  Hairline's open
//       chevron dart and its dark edge (media.dart / media.dartEdge)
//   Polestar_Skin_Hairline/Media/medallion.tga  the map marks' ground: a
//       near-black square chip, a black one-pixel outline, a faint lighter
//       line inside it (media.medallion, drawn untinted)
//   Polestar_Skin_Hairline/Media/chip.tga, chip-rim.tga  the step pins'
//       square body (a white mask Polestar tints) and its rim: a black
//       outline round a white line Polestar tints (media.pinFill, pinRim)
//   Polestar_Skin_Waymark/Media/paper.tga  dark map paper: grain and a faint
//       graticule, tileable, tinted with the ground
//   Polestar_Skin_Waymark/Media/compass.tga  the header's compass rose (mask)
//   Polestar_Skin_Waymark/Media/needle.tga, needle-edge.tga  the arrow as a
//       compass needle (media.dart / media.dartEdge)
//   Polestar_Skin_Waymark/Media/medallion.tga  map marks in a brass-ringed
//       chart disc (media.medallion, painted)
//   Polestar_Skin_Waymark/Media/dash.tga  the dashed route rule's tile
//   Polestar_Skin_Lanterns/Media/corner.tga, corner-rim.tga, cap.tga,
//       cap-rim.tga  the rounded window's corner and the pill's cap, each a
//       fill and a rim (white masks)
//   Polestar_Skin_Sheen/Media/glare.tga  light across a pane of glass: two
//       diagonal bands, stretched over a window at a low alpha

const path = require('node:path');
const { Canvas, sdf } = require('../lib/tga');

const WHITE = [1, 1, 1, 1];
const BLACK = [0, 0, 0, 1];

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

// Hairline's dart: a narrow open chevron, the polygon 30,4 50,55 30,45
// 10,55 on the 60-unit grid Polestar's skin darts use, pointing up (the
// arrow turns it), drawn as a 3-unit line and not filled (the skin's light
// touch); its edge a one-unit dark line along both sides of that line (the
// arrow lays the edge over the dart). 128 px.
const K = 128 / 60;
const DART = [[30, 4], [50, 55], [30, 45], [10, 55]].map(([x, y]) => [x * K, y * K]);
const dartShape = sdf.polygon(DART);
const dart = () => new Canvas(128, 128).fill((x, y) => Math.abs(dartShape(x, y)) - 1.5 * K, WHITE);
const dartEdge = () => new Canvas(128, 128).fill((x, y) => Math.abs(Math.abs(dartShape(x, y)) - 2 * K) - 0.5 * K, WHITE);

// Hairline's map-mark ground, 64 px for a medallion drawn at about 22: one
// screen pixel is 64 / 22 texels. A hard square (no rounding: the flat
// suites' chip), black outline, #141414 ground, a white line at 9 % inside.
const PX = 64 / 22;
const square = (inset) => sdf.box(32, 32, 32 - inset, 32 - inset);
function medallion() {
	const c = new Canvas(64, 64);
	c.fill(square(1), BLACK);
	c.fill(square(1 + PX), [0.08, 0.08, 0.08, 1]);
	c.fill(sdf.subtract(square(1 + PX), square(1 + 2 * PX)), [1, 1, 1, 0.09]);
	return c;
}

// The step pins: the body a white square the size of Polestar's round
// pin-fill (21 of 64 from the centre); the rim a black outline round it with
// a white line inside the outline, both a pixel at the pins' usual size.
const chip = () => new Canvas(64, 64).fill(sdf.box(32, 32, 21, 21), WHITE);
function chipRim() {
	const c = new Canvas(64, 64);
	c.fill(sdf.subtract(sdf.box(32, 32, 24, 24), sdf.box(32, 32, 21, 21)), BLACK);
	c.fill(sdf.subtract(sdf.box(32, 32, 21, 21), sdf.box(32, 32, 18.5, 18.5)), WHITE);
	return c;
}

// Waymark's map paper: a dark chart's grain (soft mottling) with a faint
// graticule, lines every 64 px, tileable, white with luminance 0.78-1,
// tinted in game with the ground colour.
function mapPaper(size = 256) {
	const n1 = valueNoise(size, 4, 71), n2 = valueNoise(size, 16, 73), n3 = valueNoise(size, 64, 79);
	const c = new Canvas(size, size);
	for (let y = 0; y < size; y++) {
		for (let x = 0; x < size; x++) {
			const m = n1(x, y) * 0.55 + n2(x, y) * 0.3 + n3(x, y) * 0.15;
			let l = 0.9 + (m - 0.5) * 0.16;
			const gx = Math.min(x % 64, 64 - (x % 64)), gy = Math.min(y % 64, 64 - (y % 64));
			if (gx < 0.75 || gy < 0.75) l = Math.min(1, l + 0.07);
			const i = (y * size + x) * 4;
			c.px[i] = c.px[i + 1] = c.px[i + 2] = Math.max(0, Math.min(1, l));
			c.px[i + 3] = 1;
		}
	}
	return c;
}

// Waymark's compass rose, a white mask for the window's header: a ring with
// sixteen ticks, an eight-point star (the four long points, the four short
// between them) and a small hub. 128 px.
function compassRose() {
	const c = new Canvas(128, 128);
	const C = 64;
	c.fill(sdf.ring(C, C, 58, 2.2), WHITE);
	c.fill(sdf.ring(C, C, 50, 1.2), [1, 1, 1, 0.7]);
	for (let i = 0; i < 16; i++) {
		const a = (i / 16) * Math.PI * 2, r0 = i % 2 ? 52 : 48;
		c.fill(sdf.segment(C + Math.sin(a) * r0, C - Math.cos(a) * r0, C + Math.sin(a) * 57, C - Math.cos(a) * 57, i % 2 ? 0.7 : 1.2), WHITE);
	}
	const point = (a, len, w) => {
		const s = Math.sin(a), co = Math.cos(a), ps = Math.sin(a + Math.PI / 2), pc = Math.cos(a + Math.PI / 2);
		return sdf.polygon([[C + s * len, C - co * len], [C + ps * w, C - pc * w], [C - s * 6, C + co * 6], [C - ps * w, C + pc * w]]);
	};
	for (let i = 0; i < 4; i++) c.fill(point((i * Math.PI) / 2, 46, 9), WHITE);
	for (let i = 0; i < 4; i++) c.fill(point((i * Math.PI) / 2 + Math.PI / 4, 30, 6), [1, 1, 1, 0.75]);
	c.fill(sdf.circle(C, C, 5), BLACK);
	c.fill(sdf.circle(C, C, 3.2), WHITE);
	return c;
}

// Waymark's arrow: a compass needle (a long diamond, pointing up) with a
// cut down its spine, so it reads as the needle's two faces; its edge a
// 2-unit outline. 128 px, on the skins' dart grid.
const NEEDLE = [[30, 3], [39, 32], [30, 57], [21, 32]].map(([x, y]) => [x * K, y * K]);
const needleShape = sdf.polygon(NEEDLE);
function needle() {
	const c = new Canvas(128, 128);
	const mid = 30 * K, waist = 32 * K;
	const left = (x) => x - mid, right = (x) => mid - x, north = (x, y) => y - waist, south = (x, y) => waist - y;
	// North: the right face full, the left a shade darker; south: both dark.
	c.fill(sdf.intersect(needleShape, right, north), WHITE);
	c.fill(sdf.intersect(needleShape, left, north), [0.78, 0.78, 0.78, 1]);
	c.fill(sdf.intersect(needleShape, right, south), [0.55, 0.55, 0.55, 1]);
	c.fill(sdf.intersect(needleShape, left, south), [0.42, 0.42, 0.42, 1]);
	c.fill(sdf.circle(mid, waist, 2.6 * K), [0.2, 0.2, 0.2, 1]);
	return c;
}
const needleEdge = () => new Canvas(128, 128).fill((x, y) => Math.abs(needleShape(x, y)) - K, WHITE);

// Waymark's map marks: a dark chart disc in a brass ring with eight ticks
// (painted, drawn untinted).
function compassMedal() {
	const c = new Canvas(64, 64);
	const C = 32;
	c.fill(sdf.circle(C, C, 31.5), [0, 0, 0, 0.85]);
	c.fill(sdf.circle(C, C, 30), (x, y) => {
		const t = (y - 2) / 60;
		return [0.85 - 0.35 * t, 0.68 - 0.32 * t, 0.36 - 0.2 * t, 1];
	});
	c.fill(sdf.circle(C, C, 25.5), (x, y) => {
		const t = Math.hypot(x - C, y - C * 0.8) / 30;
		return [0.16 - 0.08 * t, 0.13 - 0.07 * t, 0.09 - 0.05 * t, 1];
	});
	for (let i = 0; i < 8; i++) {
		const a = (i / 8) * Math.PI * 2;
		c.fill(sdf.segment(C + Math.sin(a) * 25.5, C - Math.cos(a) * 25.5, C + Math.sin(a) * 29, C - Math.cos(a) * 29, 0.9), [0.12, 0.08, 0.04, 1]);
	}
	return c;
}

// Waymark's route rule: a dash tile, 8 on and 8 off, 16 x 4 (tiled across
// under the step bar).
const dash = () => new Canvas(16, 4).fill(sdf.box(4, 2, 4, 1), WHITE, { feather: 0.6 });

// Lanterns' rounded frames: a quarter of a 16-px rounded corner (the
// corner's fill, a white mask) and its 1-px rim, for a nine-slice the skin
// lays itself; both 32 px for 16 units.
const corner = () => new Canvas(32, 32).fill(sdf.circle(32, 32, 32), WHITE);
const cornerRim = () => new Canvas(32, 32).fill(sdf.ring(32, 32, 31, 2), WHITE);
// The pill's cap (the left half of a capsule 32 high): tabs and buttons.
const cap = () => new Canvas(16, 32).fill(sdf.circle(16, 16, 16), WHITE);
const capRim = () => new Canvas(16, 32).fill(sdf.ring(16, 16, 15, 2), WHITE);

// Sheen's glare: light across a pane of glass, two diagonal bands (a broad
// soft one and a narrow one beside it) from the top right toward the bottom
// left, white with alpha, nothing in the corners. Stretched over a window
// at a low alpha. 256 px.
function glare(size = 256) {
	const c = new Canvas(size, size);
	const band = (centre, width, peak) => (x, y) => {
		const d = Math.abs((x + y) / size - centre) / width;
		return d >= 1 ? 0 : peak * (1 - d * d) * (1 - d * d);
	};
	const broad = band(0.78, 0.18, 1), narrow = band(1.02, 0.045, 0.85);
	for (let y = 0; y < size; y++) {
		for (let x = 0; x < size; x++) {
			const a = Math.min(1, broad(x + 0.5, y + 0.5) + narrow(x + 0.5, y + 0.5));
			const i = (y * size + x) * 4;
			c.px[i] = c.px[i + 1] = c.px[i + 2] = 1;
			c.px[i + 3] = a;
		}
	}
	return c;
}

function generate(addonRoot) {
	const addons = path.dirname(addonRoot);
	const media = (skin, name) => path.join(addons, `Polestar_Skin_${skin}`, 'Media', `${name}.tga`);
	return [
		paper().write(path.join(addons, 'Polestar_Skin_Vellum', 'Media', 'paper.tga')),
		curtain().write(path.join(addons, 'Polestar_Skin_Aurora', 'Media', 'curtain.tga')),
		veil().write(path.join(addons, 'Polestar_Skin_Aurora', 'Media', 'veil.tga')),
		dart().write(media('Hairline', 'dart')),
		dartEdge().write(media('Hairline', 'dart-edge')),
		medallion().write(media('Hairline', 'medallion')),
		chip().write(media('Hairline', 'chip')),
		chipRim().write(media('Hairline', 'chip-rim')),
		mapPaper().write(media('Waymark', 'paper')),
		compassRose().write(media('Waymark', 'compass')),
		needle().write(media('Waymark', 'needle')),
		needleEdge().write(media('Waymark', 'needle-edge')),
		compassMedal().write(media('Waymark', 'medallion')),
		dash().write(media('Waymark', 'dash')),
		corner().write(media('Lanterns', 'corner')),
		cornerRim().write(media('Lanterns', 'corner-rim')),
		cap().write(media('Lanterns', 'cap')),
		capRim().write(media('Lanterns', 'cap-rim')),
		glare().write(media('Sheen', 'glare')),
	];
}

module.exports = { name: 'skin-addons', generate };
