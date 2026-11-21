'use strict';
// The Node addon harness loads the flight game on demand, as the client does.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { tocLines } = require('../tools/lib/i18n/toc');

test('Tetris AddOns-list translations match the Node TOC source', () => {
	const toc = fs.readFileSync(path.join(__dirname, '..', 'addon', 'Polestar_Tetris', 'Polestar_Tetris.toc'), 'utf8').split(/\r?\n/);
	for (const line of tocLines('Polestar_Tetris')) assert.ok(toc.includes(line), line);
});

test('Tetris loads on demand and opens its window', () => {
	const { emitted } = runAddon({
		before: 'Polestar = { L = setmetatable({}, { __index = function(_, key) return key end }) }',
		script: `local before = PolestarTetrisAPI == nil
local ok = C_AddOns.LoadAddOn("Polestar_Tetris")
local opened = PolestarTetrisAPI.Open()
emit({ before = before, loaded = ok, opened = opened,
  shown = PolestarTetrisAPI.IsOpen(), run = PolestarTetris.Run() ~= nil })`,
	});
	assert.deepEqual(emitted, [{ before: true, loaded: true, opened: true, shown: true, run: true }]);
});

test('Tetris window uses translated labels and falls back to English', () => {
	const { emitted } = runAddon({
		before: 'Polestar = { L = setmetatable({ Next = "Suivant" }, { __index = function(_, key) return key end }) }',
		script: `C_AddOns.LoadAddOn("Polestar_Tetris")
PolestarTetrisAPI.Open()
local labels = {}
for _, region in ipairs(PolestarTetrisFrame.regions) do
  if region.kind == "FontString" then labels[region:GetText()] = true end
end
emit({ translated = labels.Suivant == true, fallback = labels.Hold == true,
  englishNext = labels.Next == true })`,
	});
	assert.deepEqual(emitted, [{ translated: true, fallback: true, englishNext: false }]);
});
