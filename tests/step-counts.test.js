'use strict';
// One count of a guide's steps for the player (POL-69): the guide window's
// step counter (UI.StepNo / UI.StepTotal), the tab tooltip ("N of M steps
// done", Engine.GetTabs(true)) and the progress bar (Engine.GetProgress,
// ProgressSoon) count the same steps. A step that keeps its number but does
// not apply now (its `when` does not hold: "Skipped for you" in the step
// browser) counts in all three, done once the live step is past it.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const GUIDE = `
w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.level = 1
Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
Polestar.Set("behavior.suggestFrom", "test")
Polestar.RegisterGuide({
	id = "test/skipped-for-you", pack = "test", title = "Skipped for you", minLevel = 1, maxLevel = 20,
	steps = {
		{ title = "Deputy Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem" } } },
		{ title = "Later on", when = { { k = "level", op = ">=", n = 10 } }, goals = { { t = "accept", quest = 33, title = "Wolves Across the Border", npc = 240, npcName = "Marshal Dughan" } } },
		{ title = "Marshal McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } },
		{ title = "Back to the abbey", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride" } } },
	},
})
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)`;

test('the step counter, the tab tooltip and the progress bar count a skipped-for-you step alike', () => {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		script: `${GUIDE}
local E, GF = Polestar.Engine, Polestar.UI.GuideFrame
E.SetGuide("test/skipped-for-you"); stub.advance(0.6)
Polestar.Set("ui.shown", true)
local function read()
	GF.Render(); GF.Layout(); stub.advance(1)
	local done, total = E.GetProgress()
	local tab = E.GetTabs(true)[1]
	local foot = GF.parts.foot
	return { live = E.GetLiveStep(), counter = GF.parts.nav.Steps.Count:GetText(), progress = { done, total },
		tab = { tab.done, tab.total }, bar = { foot.psDone, foot.psTotal } }
end
local out = { ahead = read() }
w.complete({ 783 }); stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
out.behind = read()
emit(out)`,
	}).emitted;
	// Ahead of the live step: counted, not done.
	assert.deepEqual(out.ahead, { live: 1, counter: '1 / 4', progress: [0, 4], tab: [0, 4], bar: [0, 4] });
	// Behind it: done, the total the same.
	assert.deepEqual(out.behind, { live: 3, counter: '3 / 4', progress: [2, 4], tab: [2, 4], bar: [2, 4] });
});
