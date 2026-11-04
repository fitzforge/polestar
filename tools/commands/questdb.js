'use strict';
// `polestar questdb` was retired for Forge: each subcommand prints its replacement and exits 2.

const RETIRED = {
	build: 'forge data questdb [--data DIR] [--out DIR] [--radius YD] [--droppers N] [--json]',
};

const usage = `polestar questdb was retired for Forge (docs/forge/data.md):
  polestar questdb build: forge data questdb [--data DIR] [--out DIR] [--radius YD] [--droppers N] [--json]`;

async function run(argv) {
	const sub = argv[0];
	if (Object.hasOwn(RETIRED, sub)) {
		console.error(`polestar questdb ${sub} was retired: ${RETIRED[sub]}`);
		return 2;
	}
	console.error(usage);
	return 2;
}

module.exports = { name: 'questdb', summary: 'Retired: forge data questdb', usage, run };
