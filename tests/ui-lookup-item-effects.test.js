'use strict';
// Lookup's details for an item (addon/Polestar/UI/Lookup.lua): under the facts,
// what the item does, read from the game's tooltip for it (C_TooltipInfo
// here) less its name; an item the client has not cached yet shows none,
// is asked for, and the pane redraws with it when GET_ITEM_INFO_RECEIVED
// brings it. A mount keeps its pane. An item row in the results shows the
// game's tooltip for the item on hover. Against the fake Engine of
// tests/lua/stub_ui.lua and the fake Lookup of tests/lua/stub_lookup.lua.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(script) {
	return runAddon({
		stubs: ['stub_ui.lua', 'stub_lookup.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `uistub.install()
			lookupstub.install()
			stub.login()
			local LK = Polestar.UI.Lookup
			local cached, asked = {}, {}
			Polestar.Compat.RequestItem = function(id) asked[#asked + 1] = id return cached[id] == true end
			C_TooltipInfo = {}
			function C_TooltipInfo.GetItemByID(id)
				if not cached[id] then return { lines = { { leftText = RETRIEVING_ITEM_INFO or "Retrieving item information", leftColor = { r = 1, g = 0.1, b = 0.1 } } } } end
				local white = { r = 1, g = 1, b = 1 }
				return { lines = {
					{ leftText = "Sabertooth Fang", leftColor = white },
					{ leftText = "Trinket", leftColor = white },
					{ leftText = "+3 Agility", leftColor = white },
					{ leftText = "Equip: Improves your chance to get a critical strike by 1%.", leftColor = { r = 0, g = 1, b = 0 } },
				} }
			end
			GameTooltip.SetHyperlink = function(self, link) self.link = link end
			local function effectsShown()
				local e = LK.details.psEffects
				return e and e:IsShown() and e.Text:GetText() or false
			end
			${script}`,
	}).emitted;
}

test('an item\'s page lists its stats and effects; an uncached one redraws when it arrives', () => {
	const [out] = run(`
		Polestar.Lookup.Show(nil, "item", 4386)
		local before = { effects = LK.detail.effects or false, shown = effectsShown(), asked = asked[#asked] }
		cached[4386] = true
		stub.fire("GET_ITEM_INFO_RECEIVED", 4386, true)
		local after = { effects = LK.detail.effects, text = effectsShown() }
		stub.RunScript(LK.details.psEffects, "OnEnter")
		after.tip = GameTooltip:GetOwner() == LK.details.psEffects and GameTooltip.link
		emit({ before = before, after = after })`);
	assert.deepEqual(out.before, { effects: false, shown: false, asked: 4386 }, 'not cached: no block, the item asked for');
	assert.deepEqual(out.after.effects, ['Trinket', '+3 Agility', 'Equip: Improves your chance to get a critical strike by 1%.'],
		'arrived: the tooltip lines under the name');
	assert.match(out.after.text, /^Trinket\n\+3 Agility\n\|cff[0-9a-f]{6}Equip: Improves/, 'white lines plain, the green Equip line coloured');
	assert.equal(out.after.tip, 'item:4386', 'hovering the block shows the game\'s tooltip for the item');
});

test('a mount keeps its pane; an item row shows the item\'s tooltip on hover', () => {
	const [out] = run(`
		cached[8631], cached[4386] = true, true
		Polestar.Lookup.Show("saber")
		LK.Select("mount", 8631)
		local mount = { effects = LK.detail.effects or false, shown = effectsShown() }
		local row
		for _, f in ipairs(stub.frames) do
			if rawget(f, "psResult") and f:IsShown() and f.psResult.kind == "item" and f.psResult.id == 4386 then row = f end
		end
		stub.RunScript(row, "OnEnter")
		emit({ mount = mount, rowTip = GameTooltip:GetOwner() == row and GameTooltip.link })`);
	assert.deepEqual(out.mount, { effects: false, shown: false }, 'no effects block on a mount');
	assert.equal(out.rowTip, 'item:4386');
});
