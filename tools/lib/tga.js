'use strict';
// Addon textures drawn in code, so they stay editable and licence-free.
//
//   const { Canvas, sdf } = require('./tga');
//   const c = new Canvas(64, 64);
//   c.fill(sdf.circle(32, 32, 20), [1, 1, 1, 1]);
//   c.write('addon/Polestar/Media/UI/dot.tga');
//
// Shapes are signed distance functions in pixel units (negative inside). Each
// pixel is sampled at its centre and covered by clamp(0.5 - d / feather), which
// gives one pixel of analytic anti-aliasing at feather 1 and soft glows at
// larger feathers. Colours are straight (non-premultiplied) RGBA in 0..1.
// Output is uncompressed 32-bit TGA with a top-left origin; dimensions must be
// powers of two, which every WoW client accepts.

const fs = require('node:fs');
const path = require('node:path');

const isPow2 = (n) => Number.isInteger(n) && n > 0 && (n & (n - 1)) === 0;

class Canvas {
	constructor(width, height) {
		if (!isPow2(width) || !isPow2(height)) throw new Error(`texture size must be a power of two, got ${width}x${height}`);
		this.width = width;
		this.height = height;
		this.px = new Float32Array(width * height * 4);
	}

	// Composite a shape over the canvas (source-over). `color` is [r, g, b, a]
	// or a function (x, y) -> [r, g, b, a] of the pixel centre (a gradient).
	fill(shape, color, { feather = 1 } = {}) {
		const at = typeof color === 'function' ? color : null;
		let [r, g, b, a = 1] = at ? [0, 0, 0, 0] : color;
		const { width, height, px } = this;
		for (let y = 0; y < height; y++) {
			for (let x = 0; x < width; x++) {
				const d = shape(x + 0.5, y + 0.5);
				let cov = 0.5 - d / feather;
				if (cov <= 0) continue;
				if (cov > 1) cov = 1;
				if (at) [r, g, b, a = 1] = at(x + 0.5, y + 0.5);
				const sa = a * cov;
				const i = (y * width + x) * 4;
				const da = px[i + 3];
				const oa = sa + da * (1 - sa);
				if (oa <= 0) continue;
				px[i] = (r * sa + px[i] * da * (1 - sa)) / oa;
				px[i + 1] = (g * sa + px[i + 1] * da * (1 - sa)) / oa;
				px[i + 2] = (b * sa + px[i + 2] * da * (1 - sa)) / oa;
				px[i + 3] = oa;
			}
		}
		return this;
	}

	toTGA() {
		const { width, height, px } = this;
		const buf = Buffer.alloc(18 + width * height * 4);
		buf[2] = 2; // uncompressed true-colour
		buf.writeUInt16LE(width, 12);
		buf.writeUInt16LE(height, 14);
		buf[16] = 32;
		buf[17] = 0x28; // 8 alpha bits, top-left origin
		const q = (v) => Math.max(0, Math.min(255, Math.round(v * 255)));
		for (let i = 0, o = 18; i < px.length; i += 4, o += 4) {
			buf[o] = q(px[i + 2]);
			buf[o + 1] = q(px[i + 1]);
			buf[o + 2] = q(px[i]);
			buf[o + 3] = q(px[i + 3]);
		}
		return buf;
	}

	write(file) {
		fs.mkdirSync(path.dirname(file), { recursive: true });
		fs.writeFileSync(file, this.toTGA());
		return file;
	}
}

// Signed distance helpers (pixel units).
const sdf = {
	circle: (cx, cy, r) => (x, y) => Math.hypot(x - cx, y - cy) - r,
	ring: (cx, cy, r, w) => (x, y) => Math.abs(Math.hypot(x - cx, y - cy) - r) - w / 2,
	box: (cx, cy, hw, hh, radius = 0) => (x, y) => {
		const qx = Math.abs(x - cx) - hw + radius;
		const qy = Math.abs(y - cy) - hh + radius;
		return Math.hypot(Math.max(qx, 0), Math.max(qy, 0)) + Math.min(Math.max(qx, qy), 0) - radius;
	},
	segment: (ax, ay, bx, by, r) => (x, y) => {
		const pax = x - ax, pay = y - ay, bax = bx - ax, bay = by - ay;
		const h = Math.max(0, Math.min(1, (pax * bax + pay * bay) / (bax * bax + bay * bay)));
		return Math.hypot(pax - bax * h, pay - bay * h) - r;
	},
	// Polygon from [[x, y], ...]; even-odd inside test, exact edge distance.
	polygon: (pts) => (x, y) => {
		let d = Infinity;
		let inside = false;
		for (let i = 0, j = pts.length - 1; i < pts.length; j = i++) {
			const [xi, yi] = pts[i];
			const [xj, yj] = pts[j];
			const ex = xj - xi, ey = yj - yi;
			const wx = x - xi, wy = y - yi;
			const h = Math.max(0, Math.min(1, (wx * ex + wy * ey) / (ex * ex + ey * ey)));
			d = Math.min(d, Math.hypot(wx - ex * h, wy - ey * h));
			if (yi > y !== yj > y && x < ((xj - xi) * (y - yi)) / (yj - yi) + xi) inside = !inside;
		}
		return inside ? -d : d;
	},
	union: (...shapes) => (x, y) => Math.min(...shapes.map((s) => s(x, y))),
	intersect: (...shapes) => (x, y) => Math.max(...shapes.map((s) => s(x, y))),
	subtract: (a, b) => (x, y) => Math.max(a(x, y), -b(x, y)),
	offset: (shape, by) => (x, y) => shape(x, y) - by,
};

module.exports = { Canvas, sdf, isPow2 };
