'use strict';
// `polestar talents` was retired for Forge: each subcommand prints its replacement and exits 2.

const RETIRED = {
	build: 'forge data talents build [--offline]',
	check: 'forge data talents check [--offline]',
};

const usage = `polestar talents was retired for Forge (docs/forge/data.md):
  polestar talents build: forge data talents build [--offline]
  polestar talents check: forge data talents check [--offline]`;

async function run(argv) {
	const sub = argv[0];
	if (Object.hasOwn(RETIRED, sub)) {
		console.error(`polestar talents ${sub} was retired: ${RETIRED[sub]}`);
		return 2;
	}
	console.error(usage);
	return 2;
}

module.exports = { name: 'talents', summary: 'Retired: forge data talents build | check', usage, run };
