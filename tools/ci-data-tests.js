#!/usr/bin/env node
'use strict';
// The Node test files that read the reference data (data/forever), out of a list (docs/CI.md, "Reference data"). The
// Release data job and the post-merge gates run only these on the release data: every other test runs the same with
// or without it, and the Tests job runs those.
//
//   node tools/ci-data-tests.js <test file|glob>...   the ones that read data/forever, space-separated
//
// A test reads the data when tools/testsel.js maps a data/forever file to it, or when its source names the data's
// helpers (tests/helpers/data.js, guide-engine.js) or data/forever itself.

const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.join(__dirname, '..');
const READS = /helpers\/(data|guide-engine)['"]|data\/forever|['"]forever['"]\)/;
const rel = (f) => path.relative(ROOT, path.resolve(ROOT, f)).split(path.sep).join('/');

function dataTests(files, { select = require('./testsel').select } = {}) {
	const mapped = new Set([...select(['data/forever/quests.json', 'data/forever/npcs.json', 'data/forever/zones.json']).selected.keys()].map(rel));
	return files.map(rel).filter((f) => mapped.has(f) || (fs.existsSync(path.join(ROOT, f)) && READS.test(fs.readFileSync(path.join(ROOT, f), 'utf8'))));
}

// The test files a list names: files as they are, globs ("tests/**/*.test.js") expanded.
function expand(args) {
	return args.flatMap((a) => (a.includes('*') ? fs.globSync(a, { cwd: ROOT }) : [a])).sort();
}

if (require.main === module) console.log(dataTests(expand(process.argv.slice(2))).join(' '));

module.exports = { dataTests, expand };
