'use strict';
// The Theme page's Essentials tab shows the first six skin cards (and the one in use when it is past them), with a
// More link to the full list on the Colour tab, which still shows every skin.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const P = require('../tools/commands/preview');

function run(active) {
	return runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: P.MODULE_FILES }],
		script: `uistub.install()
stub.login()
local T = Polestar.UI.Theme or Polestar.Theme
local real = T.SkinChoices
T.SkinChoices = function()
	local out = real()
	for i = 1, 9 do out[#out + 1] = { value = "extra" .. i, text = "Extra " .. i, addon = "Polestar_Skin_X" .. i } end
	return out
end
T.SkinId = function() return ${JSON.stringify(active)} end
Polestar.UI.LoadOptions(); Polestar.UI.ShowOptions("theme")
local O = Polestar.UI.Options
local function count(tab)
	O.Select("theme", tab)
	local w = O.Controls("theme", tab)["ui.skin"]
	local c = type(w.psChoices) == "function" and w.psChoices() or w.psChoices
	local values = {}
	for i, ch in ipairs(c) do values[i] = ch.value end
	return values
end
local ess = count(Polestar.L["Essentials"])
local full = count(Polestar.L["Colour"])
-- The Essentials Skin section's link: More opens the Colour tab's Skin & accent section.
O.Select("theme", Polestar.L["Essentials"])
-- Click the Skin section's More link: the Colour tab opens, with the full skin list.
local clicked
for _, card in ipairs(O.view.cards or {}) do
	if card:IsShown() and card.psName == Polestar.L["Skin"] and card.More and card.More:IsShown() then
		card.More:GetScript("OnClick")(card.More)
		clicked = true
	end
end
local opened = clicked and O.Controls("theme", Polestar.L["Colour"])["ui.skin"]
local shown = opened and (type(opened.psChoices) == "function" and opened.psChoices() or opened.psChoices) or {}
emit({ ess = ess, full = full, clicked = clicked, opened = #shown, tab = (O.view == O.page.views[Polestar.L["Colour"]]) and "Colour" or "other" })`,
	}).emitted[0];
}

test('Essentials shows six skin cards, and the full tab all of them', () => {
	const r = run('polestar');
	assert.equal(r.ess.length, 6);
	assert.deepEqual(r.ess, ['polestar', 'halo', 'hearth', 'forever', 'blizzard', 'classic']);
	assert.equal(r.full.length, 15);
});

test('Essentials adds the skin in use as a seventh card when it is past the sixth', () => {
	const r = run('extra4');
	assert.equal(r.ess.length, 7);
	assert.equal(r.ess[6], 'extra4');
});

test('the Essentials skin section links to the full list', () => {
	const r = run('polestar');
	assert.equal(r.clicked, true, 'the section has a More link');
	assert.equal(r.opened, 15);
	assert.equal(r.tab, 'Colour', 'the full list is open');
});
