'use strict';
const { readFileSync } = require('node:fs');
const path = require('node:path');
const { test } = require('node:test');
const { runAddon, STUBS } = require('./helpers/lua');

test('an external target list uses native buttons and restores the guide safely', () => {
	const script = readFileSync(path.join(STUBS, 'free-mode-target-source.lua'), 'utf8');
	runAddon({
		stubs: ['stub_qol.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] }],
		login: true,
		script,
	});
});
