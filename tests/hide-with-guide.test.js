'use strict';
// Hiding the guide (ui.shown) takes the arrow, the action buttons and the rare and transport alerts along.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('hiding the guide hides the quest item, Hearthstone, target, rare and bag buttons, and showing it brings them back', () => {
	const out = runAddon({
		stubs: ['stub_qol.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] }],
		login: true,
		script: `local q = stub.qol
		q.addItem(0, 1, 6948, 1)
		q.addItem(0, 2, 900, 1)
		q.step({ { t = "hearth" }, { t = "kill", target = "Wolf" }, { t = "use", item = 900, quest = 7, oi = 1 } })
		Polestar.Rares = { Nearby = function() return { "Thuros" } end }
		Polestar.QoL.Space = { Low = function() return true end, Junk = function() return { id = 900 } end, Armed = function() return false end, Free = function() return 1 end }
		local function shown()
			stub.runTimers()
			emit({ PolestarQuestItemButton:IsShown(), PolestarHearthButton:IsShown(), PolestarTargetButton:IsShown(), PolestarRareButton:IsShown(), PolestarBagButton:IsShown() })
		end
		Polestar.Fire("BAG_SPACE")
		shown()
		Polestar.Set("ui.shown", false)
		shown()
		Polestar.Set("ui.shown", true)
		shown()`,
	}).emitted;
	assert.deepEqual(out, [Array(5).fill(true), Array(5).fill(false), Array(5).fill(true)]);
});

test('hiding the guide hides the travel button and the arrow, and showing it brings them back', () => {
	const out = runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Theme/Theme.xml', 'Nav/Nav.xml'] }],
		login: true,
		script: `local P, Nav = Polestar.Nav.prompts, Polestar.Nav
		stub.nav.items[6948] = 1
		Nav.GetRoute = function() return { { kind = "hearth" }, { kind = "walk" } }, 1 end
		local function shown()
			stub.runTimers()
			emit({ P.Wanted() ~= nil, P.button ~= nil and P.button:IsShown(), Nav.arrow.frame:IsShown() })
		end
		stub.nav.setWaypoint({ map = 9000, x = 50, y = 20, label = "Somewhere", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 })
		Nav.Refresh()
		shown()
		Polestar.Set("ui.shown", false)
		shown()
		Polestar.Set("ui.shown", true)
		shown()`,
	}).emitted;
	assert.deepEqual(out, [[true, true, true], [false, false, false], [true, true, true]]);
});

test('no transport alert fires while the guide is hidden, and it is still due once the guide is back', () => {
	const out = runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Theme/Theme.xml', 'Nav/Nav.xml'] }],
		login: true,
		script: `local A = Polestar.Nav.alerts
		Polestar.Transit = { Now = function() return 0 end, Riding = function()
			return { kind = "boat", dock = "Menethil", route = "r", arriveIn = A.ON_BOARD - 1 }
		end }
		local alerts = 0
		Polestar.On("NAV_TRANSIT_ALERT", function() alerts = alerts + 1 end)
		Polestar.Set("ui.shown", false)
		A.Check()
		emit(alerts)
		Polestar.Set("ui.shown", true)
		emit(alerts)`,
	}).emitted;
	assert.deepEqual(out, [0, 1]);
});

test('no rare alert or sound fires while the guide is hidden', () => {
	const run = (shown) => runAddon({
		stubs: ['stub_world.lua', 'stub_rares.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Lookup/Lookup.xml', 'Rares/Rares.xml'] }],
		login: true,
		script: `local got = 0
		Polestar.On("RARE_SPOTTED", function() got = got + 1 end)
		Polestar.Set("ui.shown", ${shown})
		stub.rares.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
		stub.fire("NAME_PLATE_UNIT_ADDED", "nameplate1")
		emit({ got, #stub.sounds })
		Polestar.Rares.ShowSample() -- the options' test button works either way
		emit(got)`,
	}).emitted;
	assert.deepEqual(run(true), [[1, 1], 2]);
	assert.deepEqual(run(false), [[0, 0], 1]);
});
