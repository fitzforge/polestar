'use strict';
// The founder's emblem (founder-emblem.tga): Fitz's own gold "F" crest, the
// glyph on the card that says the Polestar founder is nearby (Rares/Toast.lua),
// drawn in its own colours. Source: tools/media/art/founder-emblem.png (Fitz's
// art, 500 x 500 RGBA, transparent ground), area-averaged down to SIZE with
// premultiplied alpha so the edges stay clean.
//
//   node tools/polestar.js media founder

const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const { Canvas } = require('../lib/tga');

const SIZE = 64;
const SOURCE = path.join(__dirname, 'art', 'founder-emblem.png');

const paeth = (a, b, c) => {
	const p = a + b - c, pa = Math.abs(p - a), pb = Math.abs(p - b), pc = Math.abs(p - c);
	return pa <= pb && pa <= pc ? a : pb <= pc ? b : c;
};

// An 8-bit RGBA, non-interlaced PNG -> { w, h, rgba }.
function decodePng(buf) {
	if (buf.readUInt32BE(0) !== 0x89504e47) throw new Error('not a PNG');
	let w = 0, h = 0;
	const idat = [];
	for (let o = 8; o < buf.length; ) {
		const len = buf.readUInt32BE(o);
		const type = buf.toString('latin1', o + 4, o + 8);
		const data = buf.subarray(o + 8, o + 8 + len);
		if (type === 'IHDR') {
			w = data.readUInt32BE(0);
			h = data.readUInt32BE(4);
			if (data[8] !== 8 || data[9] !== 6 || data[12] !== 0) throw new Error('need an 8-bit RGBA, non-interlaced PNG');
		} else if (type === 'IDAT') idat.push(data);
		else if (type === 'IEND') break;
		o += 12 + len;
	}
	const raw = zlib.inflateSync(Buffer.concat(idat));
	const stride = w * 4;
	const rgba = Buffer.alloc(stride * h);
	for (let y = 0; y < h; y++) {
		const f = raw[y * (stride + 1)];
		const src = y * (stride + 1) + 1;
		const row = y * stride;
		for (let x = 0; x < stride; x++) {
			const a = x >= 4 ? rgba[row + x - 4] : 0;
			const b = y > 0 ? rgba[row - stride + x] : 0;
			const c = x >= 4 && y > 0 ? rgba[row - stride + x - 4] : 0;
			const v = raw[src + x];
			rgba[row + x] = (f === 0 ? v : f === 1 ? v + a : f === 2 ? v + b : f === 3 ? v + ((a + b) >> 1) : v + paeth(a, b, c)) & 255;
		}
	}
	return { w, h, rgba };
}

function emblem() {
	const { w, h, rgba } = decodePng(fs.readFileSync(SOURCE));
	const c = new Canvas(SIZE, SIZE);
	const sx = w / SIZE, sy = h / SIZE;
	for (let ty = 0; ty < SIZE; ty++) {
		for (let tx = 0; tx < SIZE; tx++) {
			// Each target pixel averages the source area it covers, partial
			// source pixels weighted by their overlap.
			let r = 0, g = 0, b = 0, a = 0, area = 0;
			const x0 = tx * sx, x1 = x0 + sx, y0 = ty * sy, y1 = y0 + sy;
			for (let y = Math.floor(y0); y < Math.ceil(y1); y++) {
				const wy = Math.min(y + 1, y1) - Math.max(y, y0);
				for (let x = Math.floor(x0); x < Math.ceil(x1); x++) {
					const wgt = wy * (Math.min(x + 1, x1) - Math.max(x, x0));
					const i = (y * w + x) * 4;
					const al = (rgba[i + 3] / 255) * wgt;
					r += (rgba[i] / 255) * al;
					g += (rgba[i + 1] / 255) * al;
					b += (rgba[i + 2] / 255) * al;
					a += al;
					area += wgt;
				}
			}
			const o = (ty * SIZE + tx) * 4;
			if (a > 0) {
				c.px[o] = r / a;
				c.px[o + 1] = g / a;
				c.px[o + 2] = b / a;
			}
			c.px[o + 3] = a / area;
		}
	}
	return c;
}

function generate(addonRoot) {
	return [emblem().write(path.join(addonRoot, 'Media', 'UI', 'founder-emblem.tga'))];
}

module.exports = { name: 'founder', generate, decodePng };
