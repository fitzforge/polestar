'use strict';
// A goal row whose subject is an item shows the game's tooltip of that item,
// with the goal and the guide's lines under it; other goals keep the guide's
// own tooltip.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('hovering an item goal shows its item tooltip, the guide lines under it', () => {
	const { emitted } = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `
			uistub.install()
			stub.login()
			uistub.setGuide(uistub.elwynn, 3)
			local GF = Polestar.UI.GuideFrame
			GF.Update()
			local links = {}
			GameTooltip.SetHyperlink = function(self, link) links[#links + 1] = link; self.lines = { "ITEM " .. link } end
			local function hover(kind)
				for _, row in ipairs(GF.rows) do
					local g = row.psGoal
					if row:IsShown() and type(g) == "table" and g.t == kind then
						stub.RunScript(row, "OnEnter")
						local out = { lines = GameTooltip.lines, owner = GameTooltip:GetOwner() == row }
						stub.RunScript(row, "OnLeave")
						return out
					end
				end
			end
			emit(hover("collect"))
			emit(hover("kill"))
			emit(links)
		`,
	});
	const [item, kill, links] = emitted;
	assert.deepEqual(links, ['item:750']);
	assert.equal(item.owner, true);
	assert.equal(item.lines[0], 'ITEM item:750');
	assert.ok(item.lines.includes('Kill Young Wolf for Tough Wolf Meat'), item.lines.join('\n'));
	assert.ok(item.lines.some((l) => l.startsWith('Quest | ')), item.lines.join('\n'));
	assert.ok(!item.lines.some((l) => l.startsWith('Item | ')), 'the item tooltip replaces the Item line');
	assert.ok(!kill.lines[0].startsWith('ITEM '), 'a kill goal keeps the guide tooltip');
});
