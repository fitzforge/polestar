'use strict';
// The guide window's goals scroll bar (UI/GuideFrame.lua): pointing at it and
// away wakes it without a Lua error. Its OnEnter and OnLeave hooks are set in
// build(), outside the block that holds barWake, so they reach it as
// GF.BarWake (0.3.3 called a nil global there). Against the real Core +
// Theme + UI manifests and the fake Engine (tests/lua/stub_ui.lua).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('pointing at the goals scroll bar and away wakes it without an error', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `
uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
local goals = GF.parts.goals
local okEnter, errEnter = pcall(stub.RunScript, goals.Bar, "OnEnter")
local okLeave, errLeave = pcall(stub.RunScript, goals.Bar, "OnLeave")
emit({ enter = okEnter, leave = okLeave, err = tostring(errEnter or errLeave or "") })`,
	}).emitted;
	assert.equal(out.enter, true, `OnEnter: ${out.err}`);
	assert.equal(out.leave, true, `OnLeave: ${out.err}`);
});
