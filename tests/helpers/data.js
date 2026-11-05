'use strict';
// The local reference data (data/forever) that some tests read. A fresh clone
// (CI) has none, so those tests skip with the one message needs() gives.

const fs = require('node:fs');
const path = require('node:path');

const DATA = path.join(__dirname, '..', '..', 'data', 'forever');

// needs('quests.json', ...) -> false when data/forever holds every file, else
// the skip reason naming the missing ones.
function needs(...files) {
	const missing = files.filter((f) => !fs.existsSync(path.join(DATA, f)));
	return missing.length ? `reference data not built: data/forever has no ${missing.join(', ')} (forge data build)` : false;
}

module.exports = { DATA, needs };
