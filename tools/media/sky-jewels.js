'use strict';
// Regenerate the Sky Jewels textures with node tools/polestar.js media sky-jewels.

const fs = require('node:fs');
const path = require('node:path');
const { Canvas } = require('../lib/tga');
const { decodePng } = require('./founder');

const JEWELS = ['jewel-1', 'jewel-2', 'jewel-3', 'jewel-4', 'jewel-5', 'jewel-6'];
const ZONES = ['zone-astral', 'zone-emberforge', 'zone-frostglass', 'zone-nightbloom', 'zone-stormspire', 'zone-sunstone'];

function generate(addonRoot) {
	const media = path.join(addonRoot, '..', 'Polestar_SkyJewels', 'Media');
	const written = [];
	for (const [names, sourceSize, size] of [[JEWELS, 64, 64], [ZONES, 512, 256]]) {
		for (const name of names) {
			const file = `${name}.png`;
			const { w, h, rgba } = decodePng(fs.readFileSync(path.join(__dirname, 'art', 'sky-jewels', file)));
			if (w !== sourceSize || h !== sourceSize) throw new Error(`${file} must be ${sourceSize}x${sourceSize}`);

			const texture = new Canvas(size, size);
			if (w === size) {
				for (let i = 0; i < rgba.length; i++) texture.px[i] = rgba[i] / 255;
			} else {
				// The opaque zone art averages one 2×2 block per output pixel.
				const stride = w * 4;
				for (let y = 0; y < size; y++) {
					for (let x = 0; x < size; x++) {
						const source = (y * w + x) * 8;
						const target = (y * size + x) * 4;
						for (let channel = 0; channel < 4; channel++) {
							const i = source + channel;
							const sum = rgba[i] + rgba[i + 4] + rgba[i + stride] + rgba[i + stride + 4];
							texture.px[target + channel] = Math.round(sum / 4) / 255;
						}
					}
				}
			}
			written.push(texture.write(path.join(media, `${name}.tga`)));
		}
	}
	return written;
}

module.exports = { name: 'sky-jewels', generate };
