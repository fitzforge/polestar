'use strict';
// The open step list (UI/StepList.lua) redraws when a quest is skipped or
// brought back from elsewhere (the guide window's quest line, its banner's
// Undo) or with its own Unskip it, not only at the next redraw something else
// brings.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK } = require('./helpers/packs');

function run(first, q = 7, click = false) {
	return runAddon({
		stubs: ['stub_world.lua', 'stub_packs.lua'],
		addons: ['Polestar'],
		script: `
${TEST_PACK}
Polestar.RegisterGuide({ id = "test/list-skip", pack = "test", title = "Test guide", minLevel = 1, maxLevel = 60,
	steps = {
		{ goals = { { t = "note", text = "First" } } },
		-- Quest 8 shares the steps, so skipping 7 moves neither the live step
		-- nor the progress: only the skip itself changes what the list shows.
		-- With 7 first, its goal is the untitled step's title.
		{ goals = { ${first ? A7 + ', ' + A8 : A8 + ', ' + A7} } },
		{ goals = { ${first ? T7 + ', ' + T8 : T8 + ', ' + T7} } },
		-- Quest 9 is two steps past the live one: its skip and unskip leave
		-- the live step's view alone (no STEP_UPDATED to redraw the list).
		{ goals = { { t = "note", text = "Between" } } },
		{ goals = { { t = "accept", quest = 9, title = "Far Quest" }, { t = "accept", quest = 8, title = "A Threat Within" } } },
	},
})
stub.login()
stub.advance(0.5)
local E, SL = Polestar.Engine, Polestar.UI.StepList
E.SetGuide("test/list-skip")
stub.advance(0.5)
Polestar.Set("ui.shown", true)
SL.Toggle(true)
stub.advance(0.5)
local function unskips()
	local n = 0
	for i = 1, SL.n or 0 do
		local r = SL.rows[i]
		for j = 1, r.psN or 0 do
			if r.G[j].Unskip:IsShown() then n = n + 1 end
		end
	end
	return n
end
local before = unskips()
E.SkipQuest(${q}, true)
stub.advance(0.5)
local skipped = unskips()
${click ? `for i = 1, SL.n or 0 do
	local r = SL.rows[i]
	for j = 1, r.psN or 0 do
		local b = r.G[j].Unskip
		if b:IsShown() and b.psQuest == ${q} then b:GetScript("OnClick")(b) end
	end
end` : `E.SkipQuest(${q}, false)`}
stub.advance(0.5)
emit({ open = SL.On(), live = E.GetLiveStep(), before = before, skipped = skipped, back = unskips(), skips = SL.Skips() })
`,
	}).emitted[0];
}

const A7 = '{ t = "accept", quest = 7, title = "Kobold Camp Cleanup" }';
const A8 = '{ t = "accept", quest = 8, title = "A Threat Within" }';
const T7 = '{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup" }';
const T8 = '{ t = "turnin", quest = 8, title = "A Threat Within" }';

for (const first of [false, true]) test(`a quest skipped or brought back with the step list open shows at once${first ? ', also as an untitled step\'s first goal' : ''}`, () => {
	const out = run(first);
	assert.equal(out.open, true, JSON.stringify(out));
	assert.equal(out.before, 0, 'nothing skipped yet: ' + JSON.stringify(out));
	assert.equal(out.skipped, 2, 'the accept and the hand-in offer Unskip it at once: ' + JSON.stringify(out));
	assert.equal(out.back, 0, 'brought back: the links go at once: ' + JSON.stringify(out));
	assert.equal(out.skips, 0);
});

test('a quest outside the live step brought back elsewhere loses its Unskip it at once', () => {
	const out = run(false, 9);
	assert.equal(out.open, true, JSON.stringify(out));
	assert.equal(out.skipped, 1, 'its accept offers Unskip it: ' + JSON.stringify(out));
	assert.equal(out.back, 0, 'brought back: the link goes without another redraw: ' + JSON.stringify(out));
});

test('the step list\'s own Unskip it on a quest outside the live step brings it back and the link goes at once', () => {
	const out = run(false, 9, true);
	assert.equal(out.skipped, 1, JSON.stringify(out));
	assert.equal(out.back, 0, 'the click redraws the list (PLAYER_UNSKIPPED_QUEST): ' + JSON.stringify(out));
	assert.equal(out.skips, 0);
});
