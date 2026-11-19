'use strict';
const fs = require('node:fs');
const path = require('node:path');

// Optional continent parts predate the manifest. Listed regions are required;
// never pick up an unlisted leftover from another build in the addons folder.
function navParts(navDir) {
	const root = path.dirname(path.resolve(navDir));
	const hasToc = name => fs.existsSync(path.join(root, name, `${name}.toc`));
	const parts = ['Polestar_Nav_EK', 'Polestar_Nav_Kalimdor'].filter(hasToc);
	const file = path.join(navDir, 'PACK.json');
	if (!fs.existsSync(file)) return parts;
	const pack = JSON.parse(fs.readFileSync(file, 'utf8'));
	if (!pack || Array.isArray(pack) || typeof pack !== 'object') throw new Error(`${file}: expected a walking pack`);
	if (!Object.hasOwn(pack, 'regions')) return parts;
	const regions = pack.regions;
	if (!Array.isArray(regions) || new Set(regions).size !== regions.length) throw new Error(`${file}: invalid regions array`);
	for (const name of regions) {
		if (typeof name !== 'string' || !/^Polestar_Nav_R(?:0|1|2991)_(?:[0-9]|1[0-5])_(?:[0-9]|1[0-5])$/.test(name) || !hasToc(name)) {
			throw new Error(`${file}: invalid or missing walking-region addon`);
		}
	}
	return parts.concat(regions.sort());
}

module.exports = { navParts };
