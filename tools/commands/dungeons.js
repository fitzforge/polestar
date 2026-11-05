'use strict';
// `polestar dungeons` was retired for Forge: each subcommand prints its replacement and exits 2.

const RETIRED = {
	build: 'forge data dungeons [--source DIR] [--data DIR] [--out FILE]',
};

const usage = `polestar dungeons was retired for Forge (docs/forge/data.md):
  polestar dungeons build: forge data dungeons [--source DIR] [--data DIR] [--out FILE]`;

async function run(argv) {
	const sub = argv[0];
	if (Object.hasOwn(RETIRED, sub)) {
		console.error(`polestar dungeons ${sub} was retired: ${RETIRED[sub]}`);
		return 2;
	}
	console.error(usage);
	return 2;
}

module.exports = { name: 'dungeons', summary: 'Retired: forge data dungeons', usage, run };
