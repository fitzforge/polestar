'use strict';
// Regenerates the addon's textures. Every module in tools/media/*.js exports
// { name, generate(addonRoot, { offline }) -> [writtenPaths] }; this runs them
// all, in name order, against addon/Polestar. The generated TGAs are committed.
// offline: the generators that read client tables (game-art) read the cached
// ones under data/sources/wago only.

const fs = require('node:fs');
const path = require('node:path');

const { ROOT } = require('../lib/paths');
const MEDIA = path.join(ROOT, 'tools', 'media');
const ADDON = path.join(ROOT, 'addon', 'Polestar');

function generators() {
	if (!fs.existsSync(MEDIA)) return [];
	return fs
		.readdirSync(MEDIA)
		.filter((f) => f.endsWith('.js'))
		.sort()
		.map((f) => {
			const mod = require(path.join(MEDIA, f));
			if (!mod || typeof mod.generate !== 'function') throw new Error(`tools/media/${f} must export { name, generate(addonRoot, options) }`);
			return { file: f, mod };
		});
}

module.exports = {
	name: 'media',
	summary: 'Regenerate the addon textures (tools/media/*.js -> addon/Polestar/Media)',
	usage: [
		'usage: node tools/polestar.js media [--offline] [generator ...]',
		'',
		'Runs every generator in tools/media/ (or only the named ones) against',
		'addon/Polestar and lists the files written. --offline: no download; the',
		'client tables game-art reads come from data/sources/wago (the newest',
		'cached build holding them).',
	].join('\n'),
	async run(argv) {
		const offline = argv.includes('--offline');
		const unknown = argv.find((a) => a.startsWith('-') && a !== '--offline');
		if (unknown) {
			console.error(`media: unknown option ${unknown}`);
			return 2;
		}
		const only = new Set(argv.filter((a) => !a.startsWith('-')));
		const list = generators().filter(({ mod, file }) => !only.size || only.has(mod.name) || only.has(file.replace(/\.js$/, '')));
		if (only.size && !list.length) {
			console.error(`no media generator named ${[...only].join(', ')}`);
			return 2;
		}
		let total = 0;
		for (const { mod, file } of list) {
			const written = (await mod.generate(ADDON, { offline })) || [];
			total += written.length;
			console.log(`${mod.name || file}: ${written.length} file(s)`);
			for (const p of written) console.log(`  ${path.relative(ROOT, p)}`);
		}
		console.log(`media: ${total} file(s) written`);
		return 0;
	},
};
