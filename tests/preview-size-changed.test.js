'use strict';
// The preview's client stub runs a frame's OnSizeChanged when SetSize,
// SetWidth or SetHeight gives it a new size, as the client does (#3427): the
// settings window's header search refits its placeholder at the size it is
// drawn at, so the smallest window's renders and fit checks hold.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const P = require('../tools/commands/preview');
const { fontsFor } = require('../tools/preview/fit');

const prelude = P.metricsLua(fontsFor(1));

function texts(script) {
	const dump = P.dumpPanel({ roots: ['PolestarSizeProbe'], script }, prelude);
	const probe = dump.objects.find((o) => o.name === 'PolestarSizeProbe');
	return dump.objects.filter((o) => o.kind === 'FontString' && o.parent === probe.id && o.text).map((o) => o.text);
}

test('a new size runs OnSizeChanged with it, once per change; the same size runs nothing', () => {
	const got = texts(`local f = CreateFrame("Frame", "PolestarSizeProbe", UIParent)
f:SetSize(100, 20)
local said = f:CreateFontString()
local n = 0
f:SetScript("OnSizeChanged", function(self, w, h)
	n = n + 1
	self:SetWidth(w) -- its own handler setting its size again runs nothing more
	said:SetText(n .. ": " .. w .. "x" .. h)
end)
f:SetWidth(300)
f:SetWidth(300)
f:SetHeight(40)
f:SetSize(300, 40)`);
	assert.deepEqual(got, ['2: 300x40']);
});

test('the settings window at its smallest size shows the search wording that fits, not the longest', () => {
	const dump = P.dumpPanel({ roots: ['PolestarOptions'], script: 'Polestar.Set("ui.optionsSize", { 860, 560 })\nPolestar.UI.ShowOptions("guide")' }, prelude);
	const shown = dump.objects.filter((o) => o.kind === 'FontString' && o.shown && o.text).map((o) => o.text);
	assert.ok(!shown.includes('Ask or search: how do I hide the arrow?'), shown.join(' | '));
	P.cleanupPacks();
});
