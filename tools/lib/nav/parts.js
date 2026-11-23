'use strict';
const fs = require('node:fs');
const path = require('node:path');

// The walking maps' continent parts beside Polestar_Nav (each region's pages are inside its part).
function navParts(navDir) {
	const root = path.dirname(path.resolve(navDir));
	return ['Polestar_Nav_EK', 'Polestar_Nav_Kalimdor'].filter(name => fs.existsSync(path.join(root, name, `${name}.toc`)));
}

module.exports = { navParts };
