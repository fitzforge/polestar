'use strict';
// `polestar itemdb` was retired for Forge: each subcommand prints its replacement and exits 2.

const RETIRED = {
	build: 'forge data itemdb [--offline] [--build V] [--sources DIR] [--out DIR]',
};

const usage = `polestar itemdb was retired for Forge (docs/forge/data.md):
  polestar itemdb build: forge data itemdb [--offline] [--build V] [--sources DIR] [--out DIR]`;

async function run(argv) {
	const sub = argv[0];
	if (Object.hasOwn(RETIRED, sub)) {
		console.error(`polestar itemdb ${sub} was retired: ${RETIRED[sub]}`);
		return 2;
	}
	console.error(usage);
	return 2;
}

module.exports = { name: 'itemdb', summary: 'Retired: forge data itemdb', usage, run };
