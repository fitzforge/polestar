'use strict';
// `polestar trainers` was retired for Forge: each subcommand prints its replacement and exits 2.

const RETIRED = {
	build: 'forge data trainers [--data DIR] [--guides DIR] [--recordings DIR] [--out FILE] [--lua FILE]',
};

const usage = `polestar trainers was retired for Forge (docs/forge/data.md):
  polestar trainers build: forge data trainers [--data DIR] [--guides DIR] [--recordings DIR] [--out FILE] [--lua FILE]`;

async function run(argv) {
	const sub = argv[0];
	if (Object.hasOwn(RETIRED, sub)) {
		console.error(`polestar trainers ${sub} was retired: ${RETIRED[sub]}`);
		return 2;
	}
	console.error(usage);
	return 2;
}

module.exports = { name: 'trainers', summary: 'Retired: forge data trainers', usage, run };
