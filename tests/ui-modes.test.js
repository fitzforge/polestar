'use strict';
// Phase 5, Task 5.4: the play-mode settings the `mode` and `xprate`
// predicates read are on the options page: Guide › Play style › Modes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'];

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: FILES }],
		script: `uistub.install()\nstub.login()\nlocal UI, O = Polestar.UI, Polestar.UI.Options\n${script}`,
	}).emitted;
}

test('each mode has one control on Guide › Play style › Modes, found by search', () => {
	const [out] = run(`
		local found = {}
		for _, q in ipairs({ "Hardcore", "Self-found", "Auction house", "Group content", "XP rate" }) do
			local groups, n = O.Search(q)
			local c = groups[1] and groups[1].controls[1]
			found[q] = { n = n, key = c and c.key, kind = c and c.kind, title = groups[1] and groups[1].title }
		end
		emit(found)`);
	assert.deepEqual(out['Hardcore'], { n: 1, key: 'modes.hardcore', kind: 'toggle', title: 'Guide  \u00b7  Play style' });
	assert.equal(out['Self-found'].key, 'modes.ssf');
	assert.equal(out['Auction house'].key, 'modes.ah');
	assert.equal(out['Group content'].key, 'modes.group');
	assert.equal(out['XP rate'].key, 'modes.xprate');
	assert.equal(out['XP rate'].kind, 'slider');
	for (const q of ['Self-found', 'Auction house', 'Group content']) assert.equal(out[q].kind, 'toggle', q);
});

test('the XP rate slider runs from 1x to 5x in quarter steps', () => {
	const [c] = run(`
		local groups = O.Search("XP rate")
		local c = groups[1].controls[1]
		emit({ min = c.min, max = c.max, step = c.step })`);
	assert.deepEqual(c, { min: 1, max: 5, step: 0.25 });
});
