'use strict';
// Regenerates the committed generated files that contributor PRs leave for the
// maintainer: compile (needs data/forever), i18n sync, preview and media.
// Run this after merging a contributor PR that touches guides/, the addon's
// Lua, or player-facing English strings, and before every feature release.

const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { ROOT } = require('../lib/paths');

// A forge command (`forge guide compile`, `forge i18n sync`): the forge on
// PATH, else this checkout's release build (cargo build --release -p forge in
// rust/).
function forge(args) {
	const built = path.join(ROOT, 'rust', 'target', 'release', process.platform === 'win32' ? 'forge.exe' : 'forge');
	const bin = fs.existsSync(built) ? built : 'forge';
	const r = spawnSync(bin, args, { cwd: ROOT, stdio: 'inherit' });
	if (r.error) {
		console.error(`regen: cannot run forge (${r.error.message}): build it with \`cargo build --release -p forge\` in rust/, or put forge on PATH`);
		return 1;
	}
	return r.status === null ? 1 : r.status;
}

module.exports = {
	name: 'regen',
	summary: 'Regenerate committed files after merging contributor PRs (compile + i18n sync + preview + media)',
	usage: [
		'usage: node tools/polestar.js regen [--no-compile] [--no-i18n] [--no-preview] [--no-media]',
		'',
		'Regenerates the four sets of committed generated files that contributors',
		'do not commit themselves:',
		'',
		'  compile     addon/Polestar_Guides/Guides.lua from guides/ and data/forever (forge guide compile)',
		'  i18n sync   locale files from the addon\u2019s English strings',
		'  preview     docs/preview/*.svg from the addon\u2019s Lua (no reference data)',
		'  media       addon/Polestar/Media/*.tga from tools/media/ (no reference data)',
		'',
		'compile needs the reference data (data/forever); the rest do not.',
		'Pass --no-<step> to skip a step.',
		'',
		'Run this after merging contributor PRs that touch guides/ or the addon\u2019s',
		'Lua, and before every feature release.',
	].join('\n'),
	async run(argv) {
		const skip = new Set(
			argv
				.filter((a) => a.startsWith('--no-'))
				.map((a) => a.slice(5)),
		);

		const steps = [
			{ key: 'compile', run: () => forge(['guide', 'compile']), args: [] },
			{ key: 'i18n', run: () => forge(['i18n', 'sync']), args: ['sync'] },
			{ key: 'preview', file: 'preview', args: [] },
			{ key: 'media', file: 'media', args: [] },
		];

		let anyFailed = false;
		for (const step of steps) {
			if (skip.has(step.key)) {
				console.log(`regen: skipping ${step.key}`);
				continue;
			}
			console.log(`\nregen: ${[step.key, ...step.args].join(' ')}`);
			const code = step.run ? step.run() : await require(path.join(__dirname, `${step.file}.js`)).run(step.args);
			if (code) {
				console.error(`regen: ${step.key} exited with ${code}`);
				anyFailed = true;
			}
		}
		return anyFailed ? 1 : 0;
	},
};
