'use strict';
// What the player set aside in the open guide (UI/StepList.lua, SL.Skips: the
// finished guide's "Review N skipped" link) is counted from the steps holding
// a skip alone (Engine.SetAsideSteps): with nothing set aside no step's view
// is built, and the count is the one a read of every step's view gives.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK } = require('./helpers/packs');

function run() {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_packs.lua'],
		addons: ['Polestar'],
		script: `
${TEST_PACK}
Polestar.RegisterGuide({ id = "test/set-aside", pack = "test", title = "Test guide", minLevel = 1, maxLevel = 60,
	steps = {
		{ goals = { { t = "note", text = "First" } } },
		{ goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup" }, { t = "accept", quest = 8, title = "A Threat Within" } } },
		{ goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup" }, { t = "turnin", quest = 8, title = "A Threat Within" } } },
		{ goals = { { t = "note", text = "Between" }, { t = "accept", quest = 10, title = "Side Quest", optional = true } } },
		{ goals = { { t = "accept", quest = 9, title = "Far Quest" }, { t = "accept", quest = 8, title = "A Threat Within" } } },
	},
})
stub.login()
stub.advance(0.5)
local E, SL = Polestar.Engine, Polestar.UI.StepList
E.SetGuide("test/set-aside")
stub.advance(0.5)
-- Every step's view read, as the count was before Engine.SetAsideSteps.
local function everyStep()
	local n, seen = 0, {}
	for i = 1, E.GetStepCount() do
		local v = E.GetStepView(i)
		if v and v.skipped == true then
			n = n + 1
		elseif v and v.goals then
			for _, goal in ipairs(v.goals) do
				if goal.status ~= "done" then
					local q = goal.quest and E.IsQuestSkipped(goal.quest) and goal.quest
					if q and not seen[q] then seen[q] = true; n = n + 1
					elseif not q and goal.dismissed then n = n + 1 end
				end
			end
		end
	end
	return n
end
local GetStepView, views = E.GetStepView, 0
local function counted()
	views = 0
	local read = {}
	E.GetStepView = function(i, ...)
		if not read[i] then read[i] = true; views = views + 1 end
		return GetStepView(i, ...)
	end
	local n = SL.Skips()
	E.GetStepView = GetStepView
	return { n = n, views = views, steps = table.concat(E.SetAsideSteps(), ","), all = everyStep() }
end
local out = { counted() }
E.SkipQuest(8, true)
stub.advance(0.5)
out[#out + 1] = counted()
E.SkipGoal(4, 2)
stub.advance(0.5)
out[#out + 1] = counted()
E.Skip()
stub.advance(0.5)
out[#out + 1] = counted()
emit(out)
`,
	}).emitted[0];
}

test('the set-aside count reads only the steps holding a skip and counts as a read of every step does', () => {
	const [none, quest, goal, step] = run();
	assert.deepEqual(none, { n: 0, views: 0, steps: '', all: 0 }, 'nothing set aside: no step view built');
	assert.equal(quest.steps, '2,3,5', 'quest 8 skipped: its three steps: ' + JSON.stringify(quest));
	assert.equal(quest.n, 1, 'a quest skipped counts once: ' + JSON.stringify(quest));
	assert.equal(goal.steps, '2,3,4,5', JSON.stringify(goal));
	assert.equal(goal.n, 2, 'the optional goal dismissed: ' + JSON.stringify(goal));
	for (const s of [quest, goal, step]) {
		assert.equal(s.n, s.all, 'the count a read of every step gives: ' + JSON.stringify(s));
		assert.equal(s.views, s.steps.split(',').length, 'the views of the steps holding a skip alone: ' + JSON.stringify(s));
	}
	assert.equal(step.n, 3, 'the live step skipped too: ' + JSON.stringify(step));
});
