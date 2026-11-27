'use strict';
const assert = require('node:assert/strict');
const { test } = require('node:test');
const { runAddon } = require('./helpers/lua');

test('quest-item button offers an open equip goal on the current step', () => {
	const { emitted } = runAddon({
		stubs: ['stub_qol.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] }],
		login: true,
		script: `
		local q = stub.qol
		local b = PolestarQuestItemButton
		local worn = false
		C_Item.IsEquippedItem = function(id) return id == 4491 and worn end
		local function item() return b:GetAttribute("item") or false end
		local gear = { t = "equip", item = 4491, optional = true }
		q.step({ gear })
		emit(item())
		q.addItem(0, 1, 4491)
		q.step({ gear })
		emit({ b:GetAttribute("type"), item(), b:IsShown() })
		q.ran = {}
		q.mouseClick(b)
		emit(q.ran)
		worn = true
		stub.fire("PLAYER_EQUIPMENT_CHANGED", 1)
		stub.runTimers()
		emit(item())
		worn = false
		stub.fire("PLAYER_EQUIPMENT_CHANGED", 1)
		stub.runTimers()
		emit(item())
		q.addItem(0, 2, 900)
		q.step({ gear, { t = "use", item = 900 } })
		emit(item())
		gear.off = true
		q.step({ gear })
		emit(item())
		gear.off = nil
		gear.status = "na"
		q.step({ gear })
		emit(item())
		`,
	});
	assert.deepEqual(emitted, [
		false, ['item', 'item:4491', true], [['item', 'item:4491']],
		false, 'item:4491', 'item:900', false, false,
	]);
});
