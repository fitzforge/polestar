'use strict';
// node tools/polestar.js gear fetch (gear build was retired: forge data gear)

const path = require('node:path');
const { parseArgs } = require('node:util');
const { SOURCES } = require('../lib/paths');

const usage = `usage: node tools/polestar.js gear fetch

fetch: refresh the wowsims cache (pinned commits) that \`forge data gear\` reads.
(gear build was retired: forge data gear [--addons DIR] [--wowsims DIR])`;

function fail(msg) {
	console.error(`${msg}\n\n${usage}`);
	return 2;
}

async function runFetch() {
	await require('../lib/consume/wowsims').readWowsims({ cacheDir: path.join(SOURCES, 'wowsims'), fetch: true, log: (m) => console.error(m) });
	return 0;
}

async function run(argv) {
	const [sub] = argv;
	if (sub === 'build') {
		console.error('polestar gear build was retired: forge data gear [--addons DIR] [--wowsims DIR]');
		return 2;
	}
	if (sub === 'fetch') return runFetch();
	return fail(sub ? `unknown subcommand "${sub}"` : 'missing subcommand');
}

module.exports = { name: 'gear', summary: 'Refresh the wowsims cache forge data gear reads (gear fetch); gear build: forge data gear', usage, run };
