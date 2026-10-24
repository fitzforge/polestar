'use strict';
// `polestar maps` was retired for Forge: each subcommand prints its replacement and exits 2.

const RETIRED = {
	build: 'forge data maps build [--data DIR] [--lua FILE]',
	overlays: 'forge data maps overlays [--offline] [--build V] [--sources DIR] [--lua FILE]',
};

const usage = `polestar maps was retired for Forge (docs/forge/data.md):
  polestar maps build: forge data maps build [--data DIR] [--lua FILE]
  polestar maps overlays: forge data maps overlays [--offline] [--build V] [--sources DIR] [--lua FILE]`;

async function run(argv) {
	const sub = argv[0];
	if (Object.hasOwn(RETIRED, sub)) {
		console.error(`polestar maps ${sub} was retired: ${RETIRED[sub]}`);
		return 2;
	}
	console.error(usage);
	return 2;
}

module.exports = { name: 'maps', summary: 'Retired: forge data maps build | overlays', usage, run };
