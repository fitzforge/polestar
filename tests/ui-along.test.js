'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('the guide window shows each along-the-way objective once', () => {
	const { emitted } = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'UI/UI.xml'] }],
		script: `
			uistub.install()
			stub.login()
			uistub.setGuide(uistub.elwynn, 3)
			local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
			E.GetAlong = function()
				return {
					{ index = 1, goals = {
						{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, text = "Gray Bear Tongue" },
					} },
					{ index = 2, goals = {
						{ t = "collect", quest = 496, oi = 1, item = 3476, index = 1, text = "Gray Bear Tongue" },
						{ t = "collect", quest = 496, oi = 2, item = 3477, index = 2, text = "Creeper Ichor" },
					} },
				}
			end
			GF.Update()
			local rows = {}
			for _, row in ipairs(GF.alongRows) do
				if row:IsShown() then rows[#rows + 1] = { row.psStep, row.psGoal } end
			end
			emit(rows)
		`,
	});
	assert.deepEqual(emitted[0], [[1, 1], [2, 2]]);
});
