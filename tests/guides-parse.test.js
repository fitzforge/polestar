'use strict';
// Every guide under guides/ parses without reference data, so a fresh clone
// (CI) checks them too. The second test notes when the committed Polestar_Guides
// is out of sync with guides/ but does not fail: maintainers run `compile`
// after merging guide additions or renames.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { findGuideFiles, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
const { ROOT } = require('../tools/lib/paths');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics, format } = require('../tools/lib/dsl/diag');

const files = findGuideFiles(OFFICIAL_DIR);

test('every guide parses without errors and has its own id', () => {
	assert.ok(files.length > 100, `found ${files.length} guides`);
	const diag = new Diagnostics();
	const ids = new Map();
	for (const file of files) {
		const guide = parseGuide(fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8'), file, diag);
		assert.ok(guide.id, `${file} has no guide line`);
		assert.ok(!ids.has(guide.id), `${file} repeats the id ${guide.id} of ${ids.get(guide.id)}`);
		ids.set(guide.id, file);
	}
	assert.deepEqual(diag.errors.map(format), []);
});

test('the compiled Polestar_Guides lists the same guides as guides/', (t) => {
	const lua = fs.readFileSync(path.join(ROOT, 'addon', 'Polestar_Guides', 'Guides.lua'), 'utf8');
	const compiled = [...lua.matchAll(/^-- Source: (.+)$/gm)].map((m) => m[1]).sort();
	if (compiled.join('\n') !== files.join('\n')) {
		t.diagnostic(
			'Guides.lua is out of sync with guides/ — maintainers run ' +
				'`forge guide compile` (or `polestar regen`) after merging guide additions or renames',
		);
	}
});
