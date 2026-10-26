'use strict';
// `polestar data` was retired for Forge: each subcommand prints its replacement and exits 2.

const RETIRED = {
	build: 'forge data build --kb (as --no-kb: forge data build; the source downloads alone: forge data sources)',
	check: 'forge data check',
};

const usage = `polestar data was retired for Forge (docs/forge/data.md):
  polestar data build: forge data build --kb (as --no-kb: forge data build; the source downloads alone: forge data sources)
  polestar data check: forge data check`;

async function run(argv) {
	const sub = argv[0];
	if (Object.hasOwn(RETIRED, sub)) {
		console.error(`polestar data ${sub} was retired: ${RETIRED[sub]}`);
		return 2;
	}
	console.error(usage);
	return 2;
}

module.exports = { name: 'data', summary: 'Retired: forge data build | check | sources', usage, run };
