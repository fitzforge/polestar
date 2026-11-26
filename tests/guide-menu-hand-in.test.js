'use strict';
// The guide window's menu (UI/GuideFrameMenu.lua): "Hand in finished quests
// (N)" opens the shared hand-in guide for every ready quest.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const script = (setup) => `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({ id = "test/menu", pack = "test", title = "Menu", minLevel = 1, maxLevel = 20,
	steps = { { goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } } } })
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local GF = Polestar.UI.GuideFrame
GF.Layout(); stub.advance(1)
Polestar.Engine.SetGuide(nil)
assert(not Polestar.Engine.GetGuide() and #Polestar.Engine.GetTabs() == 0, "the menu works without any selected or open guide")
${setup}
local W = Polestar.Widgets
local got
local show = W.ShowMenu
W.ShowMenu = function(_, items, opts)
	assert(opts and opts.short, "the grouped menu keeps every action in view")
	got = items
end
GF.OpenMenu(CreateFrame("Button", nil, UIParent))
W.ShowMenu = show
local row, count = nil, 0
for _, it in ipairs(got or {}) do
	if it.icon == "icon-turnin" then row, count = it, count + 1 end
end
assert(count == 1, "the grouped menu has exactly one matching action")
if row and not row.disabled then row.onClick() end
emit({ text = row and row.text or false, disabled = row and row.disabled or false, guided = guided or false })`;

test('all ready quests: one counted row opens the shared hand-in guide without building a carried list; none, it says so', () => {
	const run = (list) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: script(`
		Polestar.Handins.Ready = function() return ${list} end
		Polestar.RoutePlan.Carried = function() error("opening the menu must not build recipient rows") end
		Polestar.UI.GuideCarried = function() guided = "carried/log"; return "lookup/carried/log" end`) }).emitted[0];
	assert.deepEqual(run('{ 1, 2 }'), { text: 'Hand in finished quests (2)', disabled: false, guided: 'carried/log' });
	assert.deepEqual(run('{}'), { text: 'None to hand in', disabled: true, guided: false });
});

test('the quest log cleanup row is always there: with quests it opens the Quest room; none or no plan, it says the log is clean', () => {
	const run = (list) => runAddon({ stubs: ['stub_world.lua'], addons: ['Polestar'], script: script(`
		Polestar.RoutePlan.Unneeded = function() return ${list} end`).replace('it.icon == "icon-turnin"', 'it.icon == "cross"') }).emitted[0];
	assert.equal(run('{ { quest = 1 } }').text, 'Clean up quest log (1)');
	assert.deepEqual(run('{}'), { text: 'Quest log is clean', disabled: true, guided: false });
	assert.deepEqual(run('nil'), { text: 'Quest log is clean', disabled: true, guided: false });
});
