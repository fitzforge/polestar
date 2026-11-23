'use strict';
// Navigation textures: the waypoint arrow, its arrival marker, map pins and the
// minimap edge pointer. Drawn from signed distance functions so they stay
// anti-aliased at any display scale and carry no third-party artwork.
//
//   node tools/polestar.js media nav
//
// Tintable layers are white; the addon colours them with SetVertexColor. Dark
// rims are baked in (black stays black under a tint), so the arrow reads on
// snow and on night-time grass alike.
//
// The 3D arrow (arrow3d, arrow3d-spec) is a pre-rendered sprite sheet from
// the software renderer in tools/media/nav/arrow3d.js.

const path = require('node:path');
const { Canvas, sdf } = require('../lib/tga');
const arrow3d = require('./nav/arrow3d');

const BLACK = [0, 0, 0];
const WHITE = [1, 1, 1];

// The arrow points up. The silhouette sits inside the texture's inscribed
// circle so SetRotation never clips a corner, and its visual centre is the
// texture centre so it pivots in place.
function arrowShape(s) {
	const k = s / 128;
	return sdf.polygon([
		[64 * k, 12 * k], // tip
		[104 * k, 108 * k], // right wing
		[64 * k, 86 * k], // tail notch
		[24 * k, 108 * k], // left wing
	]);
}

function arrow(size) {
	const c = new Canvas(size, size);
	const body = arrowShape(size);
	c.fill(sdf.offset(body, 3.5), [...BLACK, 0.55], { feather: 2 }); // rim
	c.fill(body, [...WHITE, 1]);
	return c;
}

// Facet lighting drawn over the tinted body: the left half catches light, the
// right half falls into shade, so the flat chevron reads as a ridged blade.
function arrowFacet(size) {
	const c = new Canvas(size, size);
	const body = arrowShape(size);
	const mid = size / 2;
	c.fill(sdf.intersect(body, (x) => x - mid), [...WHITE, 0.26]);
	c.fill(sdf.intersect(body, (x) => mid - x), [...BLACK, 0.24]);
	// A thin specular line along the left leading edge.
	const k = size / 128;
	c.fill(sdf.intersect(body, sdf.segment(64 * k, 18 * k, 30 * k, 102 * k, 1.6 * k)), [...WHITE, 0.55]);
	return c;
}

function arrowGlow(size) {
	const c = new Canvas(size, size);
	c.fill(sdf.offset(arrowShape(size), 2), [...WHITE, 0.9], { feather: size / 10 });
	return c;
}

// Arrival marker: a ring around a solid core, with a soft halo behind.
function arrived(size) {
	const c = new Canvas(size, size);
	const m = size / 2;
	const k = size / 128;
	c.fill(sdf.ring(m, m, 40 * k, 12 * k), [...BLACK, 0.5], { feather: 2 });
	c.fill(sdf.ring(m, m, 40 * k, 7 * k), [...WHITE, 1]);
	c.fill(sdf.circle(m, m, 16 * k), [...BLACK, 0.5], { feather: 2 });
	c.fill(sdf.circle(m, m, 13 * k), [...WHITE, 1]);
	return c;
}

function glow(size) {
	const c = new Canvas(size, size);
	const m = size / 2;
	c.fill(sdf.circle(m, m, size * 0.22), [...WHITE, 1], { feather: size * 0.4 });
	return c;
}

// Four-pointed star: Polestar's mark, used at the centre of map pins; `turn`
// radians round from upright.
function star(cx, cy, outer, inner, turn = 0) {
	const pts = [];
	for (let i = 0; i < 8; i++) {
		const r = i % 2 === 0 ? outer : inner;
		const a = (i * Math.PI) / 4 - Math.PI / 2 + turn;
		pts.push([cx + Math.cos(a) * r, cy + Math.sin(a) * r]);
	}
	return sdf.polygon(pts);
}

// A route sparkle (nav.lineStyle "sparkle"): a glint of long thin rays on
// the axes, short faint ones on the diagonals, round a bright core. Drawn
// additively over Media/Nav/glow and tinted; the rays stay inside the
// inscribed circle so SetRotation never clips them.
function sparkle(size) {
	const c = new Canvas(size, size);
	const m = size / 2;
	const k = size / 64;
	c.fill(sdf.circle(m, m, 6 * k), [...WHITE, 0.6], { feather: 10 * k });
	c.fill(star(m, m, 15 * k, 2.2 * k, Math.PI / 4), [...WHITE, 0.45], { feather: 2 * k });
	c.fill(star(m, m, 29 * k, 2.6 * k), [...WHITE, 1], { feather: 2.5 * k });
	c.fill(sdf.circle(m, m, 3.2 * k), [...WHITE, 1], { feather: 2 * k });
	return c;
}

// The line style's soft shadow (Maps/RouteLines.lua, nav.lineStyle "line"):
// a client Line stretches its texture along its length and across its
// thickness, so this is even along x and feathered across y, full at the
// middle and nothing at either edge. Tinted with the theme's scrim.
function lineSoft(size) {
	const c = new Canvas(size, size);
	const m = size / 2;
	c.fill((x, y) => Math.abs(y - m) - m / 2, [...WHITE, 1], { feather: m });
	return c;
}

// Pin frame: dark rim, white ring, white star. Drawn over pin-fill.
function pin(size) {
	const c = new Canvas(size, size);
	const m = size / 2;
	const k = size / 64;
	c.fill(sdf.ring(m, m, 22.5 * k, 9 * k), [...BLACK, 0.55], { feather: 2 });
	c.fill(sdf.ring(m, m, 22.5 * k, 5 * k), [...WHITE, 1]);
	c.fill(sdf.offset(star(m, m, 13 * k, 4.2 * k), 1.2 * k), [...BLACK, 0.35], { feather: 1.5 });
	c.fill(star(m, m, 13 * k, 4.2 * k), [...WHITE, 1]);
	return c;
}

// Pin body, tinted with the accent.
function pinFill(size) {
	const c = new Canvas(size, size);
	const m = size / 2;
	c.fill(sdf.circle(m, m, (21 * size) / 64), [...WHITE, 1]);
	return c;
}

// Minimap edge pointer: a small blunt arrowhead pointing up (outward).
function edge(size) {
	const c = new Canvas(size, size);
	const k = size / 64;
	const head = sdf.polygon([
		[32 * k, 10 * k],
		[52 * k, 50 * k],
		[32 * k, 41 * k],
		[12 * k, 50 * k],
	]);
	c.fill(sdf.offset(head, 3 * k), [...BLACK, 0.6], { feather: 2 });
	c.fill(head, [...WHITE, 1]);
	return c;
}

// Map area under a spawn cluster (world map): a soft disc with a thin rim,
// both white so the pin's subject colour tints them; drawn at low alpha.
function area(size) {
	const c = new Canvas(size, size);
	const m = size / 2;
	const k = size / 128;
	c.fill(sdf.circle(m, m, 56 * k), [...WHITE, 0.5], { feather: 10 * k });
	c.fill(sdf.ring(m, m, 59 * k, 2 * k), [...WHITE, 1], { feather: 1.5 * k });
	return c;
}

// Thin circle drawn around a pin (Pins `ring`), white for tinting; at a pin's
// backdrop size (about 20-25 px) it reads as a 2 px ring.
function ring(size) {
	const c = new Canvas(size, size);
	const m = size / 2;
	const k = size / 64;
	c.fill(sdf.ring(m, m, 27 * k, 5 * k), [...WHITE, 1], { feather: 1 });
	return c;
}

const TEXTURES = [
	['arrow', () => arrow(128)],
	['arrow-facet', () => arrowFacet(128)],
	['arrow-glow', () => arrowGlow(128)],
	['arrow3d', () => arrow3d.sheets().body],
	['arrow3d-spec', () => arrow3d.sheets().spec],
	['arrived', () => arrived(128)],
	['glow', () => glow(64)],
	['pin', () => pin(64)],
	['pin-fill', () => pinFill(64)],
	['edge', () => edge(64)],
	['area', () => area(128)],
	['ring', () => ring(64)],
	['sparkle', () => sparkle(64)],
	['line-soft', () => lineSoft(32)],
];

function generate(addonRoot) {
	const dir = path.join(addonRoot, 'Media', 'Nav');
	return TEXTURES.map(([name, draw]) => draw().write(path.join(dir, `${name}.tga`)));
}

module.exports = { name: 'nav', generate, textures: TEXTURES.map(([name]) => name), arrow3dLayout: arrow3d.LAYOUT };
