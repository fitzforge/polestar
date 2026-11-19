'use strict';
// Regenerate the Sky Jewels textures with node tools/polestar.js media sky-jewels.
// The PNGs in art/sky-jewels are original ImageGen artwork cropped and sized
// for the game. The four synthesized Ogg sound effects are shipped as recorded.

const fs = require('node:fs');
const path = require('node:path');
const { Canvas } = require('../lib/tga');
const { decodePng } = require('./founder');

const JEWELS = ['jewel-1', 'jewel-2', 'jewel-3', 'jewel-4', 'jewel-5', 'jewel-6'];
const ZONES = ['zone-astral', 'zone-emberforge', 'zone-frostglass', 'zone-nightbloom', 'zone-stormspire', 'zone-sunstone'];

function generate(addonRoot) {
	const written = [];
	for (const [names, size] of [[JEWELS, 64], [ZONES, 512]]) {
		for (const name of names) {
			const file = `${name}.png`;
			const { w, h, rgba } = decodePng(fs.readFileSync(path.join(__dirname, 'art', 'sky-jewels', file)));
			if (w !== size || h !== size) throw new Error(`${file} must be ${size}x${size}`);

			const texture = new Canvas(w, h);
			for (let i = 0; i < rgba.length; i++) texture.px[i] = rgba[i] / 255;
			written.push(texture.write(path.join(addonRoot, 'Media', 'SkyJewels', `${name}.tga`)));
		}
	}
	return written;
}

module.exports = { name: 'sky-jewels', generate };
