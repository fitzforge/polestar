'use strict';
// The reported-problems gate (tools/reported-gate.js, #2042) and its map, tests/reported-gate.json: every test the map
// names for a player's report exists where it says, so renaming or deleting a test that pins a report fails here until
// the map follows; and the runner reads node's, cargo's and the seeds' results the way they print them.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { loadGate, pins, nodeFiles, cargoGroups, cargoArgs, matches, issuesFor, readTap, readCargo, notApplicable } = require('../tools/reported-gate');

const ROOT = path.join(__dirname, '..');
const gate = loadGate();
// A source file as its strings read: a quote escaped with a backslash is the quote.
const text = (file) => fs.readFileSync(path.join(ROOT, file), 'utf8').replace(/\\(['"])/g, '$1');
const SEED_DIR = 'rust/crates/forge-judge/src/seed';
const seedSources = () => [path.join(SEED_DIR, 'caves.rs'), ...fs.readdirSync(path.join(ROOT, SEED_DIR, 'reported')).map((f) => path.join(SEED_DIR, 'reported', f))].map(text).join('\n');

test('every report in the map has its tests, a reason nothing can be checked, or the report it duplicates', () => {
	const bad = [];
	for (const [issue, v] of Object.entries(gate.issues)) {
		const kinds = ['tests', 'uncheckable', 'same'].filter((k) => k in v);
		if (kinds.length !== 1) bad.push(`#${issue}: one of tests, uncheckable or same`);
		else if (v.tests && !v.tests.length) bad.push(`#${issue}: no tests`);
		else if (v.uncheckable !== undefined && !(typeof v.uncheckable === 'string' && v.uncheckable.length > 20)) bad.push(`#${issue}: say why nothing can be checked`);
		else if (v.same !== undefined && !(gate.issues[v.same] && gate.issues[v.same].tests)) bad.push(`#${issue}: same as #${v.same}, which has no tests`);
	}
	// A seed the gate lets fail says why: the guides-reported case it ports has changed since.
	for (const [name, why] of Object.entries(gate.seedDrift || {})) {
		if (!(typeof why === 'string' && /guides-reported case/.test(why))) bad.push(`seedDrift ${name}: say which case it is behind`);
	}
	assert.deepEqual(bad, []);
});

test('every test the map names exists where it says', () => {
	const seeds = seedSources();
	const cache = new Map();
	const src = (f) => (cache.has(f) ? cache.get(f) : cache.set(f, text(f)).get(f));
	const missing = [];
	for (const { issue, test: t } of pins(gate)) {
		if (t.node) {
			if (!fs.existsSync(path.join(ROOT, t.node)) || !src(t.node).includes(t.test)) missing.push(`#${issue}: ${t.node}: ${t.test}`);
		} else if (t.seed !== undefined) {
			if (!seeds.includes(t.seed)) missing.push(`#${issue}: seed ${t.seed}`);
		} else if (t.cargo) {
			const here = t.target === 'lib' ? `rust/crates/${t.cargo}/src/` : [`rust/crates/${t.cargo}/tests/${t.target}/`, `rust/crates/${t.cargo}/tests/${t.target}.rs`];
			const placed = [].concat(here).some((p) => t.file === p || t.file.startsWith(p));
			if (!placed || !fs.existsSync(path.join(ROOT, t.file)) || !new RegExp(`\\bfn ${t.test}\\s*\\(`).test(src(t.file))) missing.push(`#${issue}: ${t.cargo} ${t.target} ${t.file}: fn ${t.test}`);
		} else {
			missing.push(`#${issue}: an entry with no node, seed or cargo: ${JSON.stringify(t)}`);
		}
	}
	assert.deepEqual(missing, []);
});

test('the gate runs guides-reported whole, each named node file once and one cargo run per crate and test target', () => {
	const files = nodeFiles(gate);
	assert.ok(files.includes('tests/guides-reported.test.js'));
	assert.equal(new Set(files).size, files.length);
	const groups = cargoGroups(gate);
	assert.equal(new Set(groups.map((g) => `${g.crate} ${g.target}`)).size, groups.length);
	const addon = groups.find((g) => g.crate === 'forge-addontest');
	assert.deepEqual(cargoArgs(addon, 4).slice(0, 11), ['test', '--manifest-path', 'rust/Cargo.toml', '--profile', 'quick', '-p', 'forge-addontest', '--test', 'addontest', '--', '--test-threads']);
	assert.deepEqual(cargoArgs({ crate: 'forge-data', target: 'lib', names: ['x'] }, 2), ['test', '--manifest-path', 'rust/Cargo.toml', '--profile', 'quick', '-p', 'forge-data', '--lib', '--', '--test-threads', '2', 'x']);
	assert.equal(JSON.parse(fs.readFileSync(path.join(ROOT, 'package.json'), 'utf8')).scripts['test:reported'], 'node tools/reported-gate.js');
});

test('a failing test is traced to its report through the parts a name fills in', () => {
	assert.ok(matches("${DUROTAR}: tor's report: Securing the Lines is taken", "forever/horde/orc/01-durotar.guide: tor's report: Securing the Lines is taken after"));
	assert.ok(matches('{TELDRASSIL}: Pynte\'s report', "forever/alliance/nightelf/01-teldrassil.guide: Pynte's report: Flight"));
	assert.ok(!matches("${DUROTAR}: tor's report: Securing", 'forever/horde/orc/01-durotar.guide: Securing the Lines'));
	assert.deepEqual(issuesFor(gate, 'node', 'Every Horde route: The Adventurer is never accepted before The Red Messenger is handed in (#792)'), [792]);
	assert.ok(issuesFor(gate, 'cargo', 'trainer_never_spends_gold_even_with_saved_bulk_training_settings').includes(1831));
	assert.ok(issuesFor(gate, 'seed', "forever/alliance/02-westfall.guide: Alba Fairmoon's chain is given to Humans too (#144 lifted by players' recordings)").includes(144));
});

test("the runner reads node's TAP, cargo's lines and a seed that names a guide the tree doesn't have", () => {
	const tap = ['TAP version 13', '# Subtest: a', 'ok 1 - a', '    not ok 1 - inner one', 'not ok 2 - b (\\#421)', 'ok 3 - c # SKIP no data', 'not ok 4 - d # TODO #123'].join('\n');
	assert.deepEqual(readTap(tap), { failed: ['inner one', 'b (#421)'], skipped: ['c'], todo: ['d'] });
	const cargo = ['running 3 tests', 'test qol::a_test ... ok', 'test engine_reset::b_test ... FAILED', 'test x::tests::c_test ... ignored'].join('\n');
	assert.deepEqual([...readCargo(cargo)], [['a_test', 'ok'], ['b_test', 'FAILED'], ['c_test', 'ignored']]);
	const guides = path.join(ROOT, 'guides');
	assert.equal(notApplicable({ failures: ['forever/horde/no-such-folder/01-durotar.guide compiles'] }, guides), true);
	assert.equal(notApplicable({ failures: ['forever/horde/no-such-folder/01-durotar.guide compiles', 'an order'] }, guides), false);
	assert.equal(notApplicable({ failures: ['forever/horde/02-the-barrens.guide compiles'] }, guides), false, 'a guide the tree has that does not compile is a failure');
});
